//
//  GameMain.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 26/04/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//Main 5 Letter Game
import SwiftUI


struct CallGame: View {
    
    var body: some View {
        
        
       
        NavigationView {
            
            
            Game()
            
            
            
            
        }
        
        
        
    }
    
}






//Main Struct PreViews
struct CallGame_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CallGame()
        
    }
}



struct Game: View {
    
    //Get JSON Data
    @ObservedObject var fiveLetterDictionary = DataLoader()
    
    @State private var newRandomWord = false
    @State private var randomWord = ""
    
    //Tile Display Word
    @State private var displayRandomWord = ""
    @State private var shuffledRandomWord = ""
    
    //Sorted word for player
    @State private var sortedRandomWord = ""
    
    
    //Random Word Letters
    @State private var randomFirstLetter = ""
    @State private var randomSecondLetter = ""
    @State private var randomThirdLetter = ""
    @State private var randomFourthLetter = ""
    @State private var randomFifthLetter = ""
    
    //Players Letter Pad
    @State private var playerSortedFirstLetter = ""
    @State private var playerSortedSecondLetter = ""
    @State private var playerSortedThirdLetter = ""
    @State private var playerSortedFourthLetter = ""
    @State private var playerSortedFifthLetter = ""
    
    
    //Show Letter State
    @State private var showPickLetters = false
    @State private var showRandomLetters = false
    @State private var showPickedLetters = false
    
    //Played Letters
    @State private var playedLetterOne = ""
    @State private var playedLetterTwo = ""
    @State private var playedLetterThree = ""
    @State private var playedLetterFour = ""
    @State private var playedLetterFive = ""
    
    
    //Variable to get all played letters
    @State private var getAllPlayedLetters = ""
    @State private var letterPlayedCompleted = false
    
    
    //Game Logo
    @State private var gameLogoImage = false
    
    //Game Intro Alphabets
    @State private var gameAlphabetIntro = false
    @State private var showIntroLetterOne = false
    @State private var showIntroLetterTwo = false
    @State private var showIntroLetterThree = false
    @State private var showIntroLetterFour = false
    @State private var showIntroLetterFive = false
    @State private var showIntroLetterSix = false
    @State private var showIntroLetterSeven = false
    @State private var showIntroLetterEight = false
    
    //Show Game Statistics
    @State private var showGameStats = false
    
    
    //Play Inro Music
    @State private var playIntroMusic = true
    
    //Play Background Music
    @State private var playBackgroundMusic = false
    
    
    //Game Statistics
    @State private var correctAnswerCount = 0
    
    //Scoring Variable
    @State private var correctScore = 0
    
    
    //Show high Score
    @State private var  highScore = 0
    @State private var showHighScore = true
    
    //Set Question Timer
    @State private var questionTimeCountdown = false
 

    //Set Game Timer
    @State private var gameTimeCounter = 300 //5 minues
    
    @State private var gameOverStatus = false
    @State private var gameStatus = false
    
    //New Game Button
    @State private var showNewGameButton = false
    
    //Game Over Message
    @State private var gameOverMessage = ""
    
    
    
    //Reveal score bubble
    @State private var showCorrectScoreBubble = false
    @State private var correctScoreBubble = 0
    

    //Show Alert for non completion of letter entry
    @State private var showAlertCompleteLetterEntry = false
    
    
    //Help Tips
 
    @State private var showHelpTipsCover = true
     @State private var showTeSecondsCover = true
    @State private var showSpellJumbledWordTip = true
    @State private var showOrangeRackWordTip = true
    @State private var showThreeMinuteGameTip = true
    @State private var showConfirmButton = true
    @State private var showDeleteLetter = true
    @State private var showTipsEnd = true //Reset
    
    
    
    
    
    
    //Environement Game and Question Timer
    @EnvironmentObject var gameQuestionTimer: GameQuestionTimer
    
    



    
    
    //Reset variable for new word
    func resetForNewWord() {
        
        
       

        //Random Word
       
        self.randomWord = ""
        
        //Tile Display word
        self.displayRandomWord = ""
        self.shuffledRandomWord = ""
        
        //Sorted Random Word
        self.sortedRandomWord = ""
        
        //Random Word Letters
        self.randomFirstLetter = ""
        self.randomSecondLetter = ""
        self.randomThirdLetter = ""
        self.randomFourthLetter = ""
        self.randomFifthLetter = ""
        
        //Reset Played Letter
        self.playerSortedFirstLetter = ""
        self.playerSortedSecondLetter = ""
        self.playerSortedThirdLetter = ""
        self.playerSortedFourthLetter = ""
        self.playerSortedFifthLetter = ""
        
        
        //Played Letters
        self.playedLetterOne = ""
        self.playedLetterTwo = ""
        self.playedLetterThree = ""
        self.playedLetterFour = ""
        self.playedLetterFive = ""
        
        //Reset Collected Letters
        self.getAllPlayedLetters = ""
        self.letterPlayedCompleted = false
        
       
        
        
       
        
        
    }//End of reset
    
    
    func getNewRandomWord() {
        
        self.randomWord = self.getRandomWord()
         
         //Holder Variable for Random word generator
         self.displayRandomWord = self.randomWord
        
         
         //For Players
         self.sortedRandomWord = String(self.displayRandomWord.shuffled())
        
        
        //User While loop
        while self.sortedRandomWord == self.displayRandomWord {
            
        self.sortedRandomWord = String(self.displayRandomWord.shuffled())
            
        }
        
        self.shuffledRandomWord = String(self.randomWord.shuffled())
        
        while self.shuffledRandomWord == self.randomWord {
        
         self.shuffledRandomWord = String(self.randomWord.shuffled())
        }
         
         //Run Index for Random word
         self.extractRandomWordChar(inRandomWord: self.shuffledRandomWord)
         
         //Run index for Sorted word
         self.extractPlayerSortedChar(inSortedWord: self.sortedRandomWord)
        
    }
    
    //Reset word after 5 second Count down
    func wordTimeOver() {
        
        //Reset variables
        resetForNewWord()
        
        //Create new random word
        getNewRandomWord()
        
        
        
    }//End Word Time Over
    
    
    
   
    //Function to process all placyed letters
    func processPlayedLetters(inLetterOne:String,inLetterTwo:String,inLetterThree:String,inLetterFour:String,inLetterFive:String) -> String {
        
        var playerWord = ""
        
        
        if self.letterPlayedCompleted {
            
            
            playerWord = inLetterOne + inLetterTwo + inLetterThree + inLetterFour + inLetterFive
          
            
            
        }

        
        return playerWord
    
    }//End played word
    
    //Fucntion to process played letters
    func processAnswer(inPlayedLetter:String, inRandomWord:String) {
        
        
        //Check t make sure that all letters have been played
        if self.letterPlayedCompleted {
            
            
            
            if inPlayedLetter == inRandomWord {
                
                //Toggle show score bubble
                self.showCorrectScoreBubble.toggle()
                //Play Correct Sount
                gameAudioPlayerNormal(sound: "CorrectSound", type: "mp3")
                
                //Assign value to the bubble
                self.correctScoreBubble = 20
                
            
                //Add to the count
                self.correctAnswerCount += 1
                
                //Set the show bubble back to false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    //Reset the score back to Zero
                    self.correctScoreBubble = 0
                    self.showCorrectScoreBubble.toggle()
                }
                
                //Add Score
                self.correctScore += 20
                
            } else {
                
                gameAudioPlayerNormal(sound: "WrongAnswerSound", type: "mp3")
                
                
            }
            
            
        }
        
    }//End Process Answer
    
    //Function to process enter button pressed
    func acceptWord() {
      
     
                                                   
                                                   
                                                   
                   self.getAllPlayedLetters = self.processPlayedLetters(inLetterOne: self.playedLetterOne, inLetterTwo: self.playedLetterTwo, inLetterThree: self.playedLetterThree, inLetterFour: self.playedLetterFour, inLetterFive: self.playedLetterFive)
                   
                   //Process correct answer
                   self.processAnswer(inPlayedLetter: self.getAllPlayedLetters, inRandomWord: self.displayRandomWord)
                   
                   
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                               
                               //Reset Counter
                               self.gameQuestionTimer.mainQuestionTimerLimit = 10
                               
                               self.resetForNewWord()
                               self.getNewRandomWord()
                               
                               //Check for correct display
                               if self.shuffledRandomWord == self.displayRandomWord {
                                   
                                   self.shuffledRandomWord = String(self.randomWord.shuffled())
                               }
                               
                
                    
                            }
    
        
                
    }//End of Accepted word
    
    
    //Funciton to process bonus point for player
    func processBonusPoint(inHighScore: Int, currentGameScore:Int) -> Int {
        
        
        var bonusPonts = 0
        
        if (inHighScore >= 150 && inHighScore <= 199) && (currentGameScore >= inHighScore) {
            
            bonusPonts = 50 //Bonus extra point for player
            
            
            
        } else if (inHighScore >= 200 && inHighScore <= 299) && (currentGameScore >= inHighScore) {
            
            
            bonusPonts = 100 //Bonus extra point for player
            
            
        } else if inHighScore >= 300 && (currentGameScore >= inHighScore) {
            
            bonusPonts = 200 //200 extra points for player
            
        } else  if currentGameScore >= 300 {
            
            bonusPonts = 20 //No extra points for player
            
        } else {
            
            bonusPonts = 0
        }
        
        
        
        return bonusPonts
        
    }
    
    
    
    
    //Function to get random word
    func getRandomWord() -> String {
        
        let wordDictionary = fiveLetterDictionary.datastructure
        
        let randomWord = wordDictionary.randomElement()!
        
        print(randomWord.word)
        
        
        return randomWord.word
        
    }
    
    
    //Process random word to get character
    func extractRandomWordChar(inRandomWord:String) {
        
        
        //First letter
        self.randomFirstLetter = String(inRandomWord[inRandomWord.startIndex])
        
        //Second Letter
        self.randomSecondLetter = String(inRandomWord[inRandomWord.index(after: inRandomWord.startIndex)])
        
        //Third Letter
        let localRandomThirdLetter = inRandomWord.index(inRandomWord.startIndex, offsetBy: 2)
        
        self.randomThirdLetter = String(inRandomWord[localRandomThirdLetter])
        
        //Forth Letter
        let localRandomFourthLetter = inRandomWord.index(inRandomWord.startIndex, offsetBy: 3)
        
        self.randomFourthLetter = String(inRandomWord[localRandomFourthLetter])
        
        //Fifth Letter
        self.randomFifthLetter = String(inRandomWord[inRandomWord.index(before: inRandomWord.endIndex)])
        
        
    }
    
    //Process Player sorted word
    func extractPlayerSortedChar(inSortedWord:String) {
        
        //First Letter
        self.playerSortedFirstLetter = String(inSortedWord[inSortedWord.startIndex])
        
        //Second Letter
        self.playerSortedSecondLetter = String(inSortedWord[inSortedWord.index(after: inSortedWord.startIndex)])
        
        //Third Letter
        let localSortedThirdLetter = inSortedWord.index(inSortedWord.startIndex,offsetBy: 2)
        self.playerSortedThirdLetter = String(inSortedWord[localSortedThirdLetter])
        
        //Forth Letter
        let localSortedFourthLetter = inSortedWord.index(inSortedWord.startIndex,offsetBy: 3)
        self.playerSortedFourthLetter = String(inSortedWord[localSortedFourthLetter])
        
        //Fifth and the last letter
        self.playerSortedFifthLetter = String(inSortedWord[inSortedWord.index(before: inSortedWord.endIndex)])
        
        
    }
    
    //Funtion to process Tap action
    func playerOnTapAction(letterPlayed:String) {
        
        
        
        if self.playedLetterOne == "" {
            
            self.playedLetterOne = letterPlayed
            
        } else if self.playedLetterTwo == "" {
            
            self.playedLetterTwo = letterPlayed
            
        } else if self.playedLetterThree == "" {
            
            self.playedLetterThree = letterPlayed
            
        } else if self.playedLetterFour == "" {
            
            self.playedLetterFour = letterPlayed
            
        } else if self.playedLetterFive == "" {
            
            self.playedLetterFive = letterPlayed
        }
        
        
    }
    

    
    
  


    
    
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            //Set background
            LinearGradient(gradient: Gradient(colors: [.blue, .white,.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
                .onAppear() {
                    
                    if self.playIntroMusic {
                        
                        gameAudioPlayerNormal(sound: "UfoSymphonyShaker", type: "mp3")
                        
                        //Toggle Music Play State
                        self.playIntroMusic.toggle()
                        
                    }
                    
                    
                    
            }//End on Appear
            
    
        
                VStack {
                    
                    HStack {
                
                            Text("Play 5 ")
                                .font(.largeTitle).foregroundColor(Color.red).bold()
                        
                                .onAppear() {
                                    
                                    
                                    self.gameLogoImage = true
                                    self.gameAlphabetIntro = true
                                    
                                    
                                    if self.gameAlphabetIntro {
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        
                                        self.showIntroLetterOne = true
                                        
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            
                                            self.showIntroLetterTwo = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            
                                            self.showIntroLetterThree = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            
                                            self.showIntroLetterFour = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                            
                                            self.showIntroLetterFive = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                            
                                            self.showIntroLetterSix = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                            
                                            self.showIntroLetterSeven = true
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                            
                                            self.showIntroLetterEight = true
                                        }
                                        
                                        
                                    }//End of gameAlphabet Intro
                        }
                        
                        Image("WoodBlock")
                            .resizable()
                            .frame(width:40,height: 40)
                        
                    }
                            
                        //Spacer().frame(height:40)
                    
                    HStack {
                        
                                    Button(action: {
                                        
                                        //Stop Intro Music
                                        stopMainSound()
                                        
                                        
                                        self.gameStatus = true
                                        
                                        
                                        
                                        //Make Alphabet Intro disapear
                                        if self.gameAlphabetIntro {
                                            
                                                self.gameAlphabetIntro = false
                                                self.gameAlphabetIntro = false
                                                self.showIntroLetterOne = false
                                                self.showIntroLetterTwo = false
                                                self.showIntroLetterThree = false
                                                self.showIntroLetterFour = false
                                                self.showIntroLetterFive = false
                                                self.showIntroLetterSix = false
                                                self.showIntroLetterSeven = false
                                                self.showIntroLetterEight = false
                                          
                                        }
                                        
                                        
                                        //Make Logo disapear
                                        
                                        if self.gameLogoImage {
                                        
                                       self.gameLogoImage.toggle()
                                            
                                        } else if self.gameLogoImage == false {
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            self.gameLogoImage.toggle()
                                                
                                                
                                        }
                                        }
                                       
                                        
                                        
                                        
                                            //Random Numbers
                                            
                                        self.showRandomLetters.toggle()
                                            
                                      
                                        
                                        //Picker Letters
                                        
                                            
                                            //Delay delivery by 3 seconds
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            
                                                self.showPickLetters.toggle()
                                                
                                                //Play game transion Sound Effect
                                                gameAudioPlayerNormal(sound: "SlideWhistleIntro", type: "mp3")
                                            
                                            }
                                       
                                        
                                        //Picked Letters
                                    
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.showPickedLetters.toggle()
                                                
                                                //Play game transion Sound Effect
                                                gameAudioPlayerNormal(sound: "SlideWhistleIntro", type: "mp3")
                                            }
                                        
                                        
                                        //Show Game Statistics
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            self.showGameStats.toggle()
                                            
                                        
                                        }
                                        
                                        
                                        
                                        //Set state random word to true
                                        self.newRandomWord = true
                                        
                                        //Call New Random word Function
                                        self.getNewRandomWord()
                                       
                                        
                                        
                                    
                                        
                                        
                                        //Run Index for Random word
                                        self.extractRandomWordChar(inRandomWord: self.shuffledRandomWord)
                                        
                                        //Run index for Sorted word
                                        self.extractPlayerSortedChar(inSortedWord: self.sortedRandomWord)
                                    
                                       
                                        //Reset Correnct Answer Counter
                                        self.correctAnswerCount = 0
                                        
                                        
                                        if self.showNewGameButton {
                                            
                                        self.showNewGameButton = false
                                            self.gameTimeCounter = 300
                                        }
                                        
                                       
                                        
                                    }) {
                                        
                                        
                                        Text("Begin / Exit")
                                            .frame(width:150,height: 40)
                                            .background(Color.blue)
                                            .foregroundColor(Color.yellow)
                                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                        .shadow(radius: 6)
                                        
                                            
                                            
                                    }//End of Button
                        
                        ZStack {
                            
                            if self.showTipsEnd {
                                
                                    Text("Reset Tips")
                                        .frame(width:230,height: 40)
                                        .background(Color.yellow)
                                        .foregroundColor(Color.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                        .onTapGesture {
                                            
                                            //Reset all tips
                                            self.showThreeMinuteGameTip.toggle()
                                            self.showOrangeRackWordTip.toggle()
                                            self.showSpellJumbledWordTip.toggle()
                                            self.showHelpTipsCover.toggle()
                                            self.showTeSecondsCover.toggle()
                                            self.showConfirmButton.toggle()
                                            self.showDeleteLetter.toggle()
                                }
                            
                            }
                            
                            if self.showDeleteLetter{
                                                           
                                           Text("Blue X delete letter")
                                                   .frame(width:230,height: 40)
                                                   .background(Color.yellow)
                                                   .foregroundColor(Color.blue)
                                                   .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                                   .onTapGesture {
                                                       
                                                       //Reveal Next Tip
                                                       self.showDeleteLetter.toggle()
                                                   }
                                                   .transition(.slide)
                                                   .animation(.default)
                                       
                                       
                                   }
                            
                            
                            if self.showConfirmButton {
                                                           
                                       Text("Blue button ⏎ to confirm")
                                               .frame(width:230,height: 40)
                                               .background(Color.yellow)
                                               .foregroundColor(Color.blue)
                                               .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                               .onTapGesture {
                                                   
                                                   //Reveal Next Tip
                                                   self.showConfirmButton.toggle()
                                               }
                                               .transition(.slide)
                                               .animation(.default)
                                   
                                   
                               }
                            
                            if self.showThreeMinuteGameTip {
                                
                                    Text("Game play is 3 minutes")
                                            .frame(width:230,height: 40)
                                            .background(Color.yellow)
                                            .foregroundColor(Color.blue)
                                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                            .onTapGesture {
                                                
                                                //Reveal Next Tip
                                                self.showThreeMinuteGameTip.toggle()
                                            }
                                            .transition(.slide)
                                            .animation(.default)
                                
                                
                            }
                            
                            if self.showTeSecondsCover {
                                
                                    Text("You have 10 seconds")
                                        .frame(width:230,height: 40)
                                        .background(Color.yellow)
                                        .foregroundColor(Color.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                        .onTapGesture {
                                            
                                            //Reveal Next Tip
                                            self.showTeSecondsCover.toggle()
                                        }
                                        .transition(.slide)
                                        .animation(.default)
                            }
                            
                            if self.showOrangeRackWordTip {
                                
                                    Text("Use orange rack")
                                        .frame(width:230,height: 40)
                                        .background(Color.yellow)
                                        .foregroundColor(Color.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                        .onTapGesture {
                                            
                                            //Reveal Next Tip
                                            self.showOrangeRackWordTip.toggle()
                                        }
                                        .transition(.slide)
                                        .animation(.default)
                                        
                            }
                            
                            if self.showSpellJumbledWordTip {
                                                       
                                       Text("Spell jumbled word")
                                           .frame(width:230,height: 40)
                                           .background(Color.yellow)
                                           .foregroundColor(Color.blue)
                                           .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                           .onTapGesture {
                                               
                                               //Reveal Next Tip
                                               self.showSpellJumbledWordTip.toggle()
                                           }
                                          .transition(.slide)
                                          .animation(.default)
                               }
                            
                            if self.showHelpTipsCover {
                                
                                    Text("Instructions")
                                        .frame(width:230,height: 40)
                                        .background(Color.yellow)
                                        .foregroundColor(Color.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                        .onTapGesture {
                                            
                                            //Reveal Next Tip
                                            self.showHelpTipsCover.toggle()
                                        }
                                        .transition(.slide)
                                        .animation(.default)
                                    
                                        
                            }
                            
                           
                           
                            
                            
                            
                            
                            
                            
                            
                        }//End of ZStack
                        
                    
                    }//End of HStack
                    
                    if self.gameStatus {
                        
                        //Spacer().frame(height:20)
                        
                        ZStack {
                            Rectangle()
                               .frame(width:200,height: 20)
                               .foregroundColor(Color.clear)
                            
                                .onAppear() {
                                    
                                    self.gameOverMessage = "Game Over!!!"
                            }
                            
                                
                        
                            if self.gameQuestionTimer.mainQuestionTimerLimit == 0 && self.gameQuestionTimer.mainGameTimerLimit > 0 && self.gameLogoImage == false {
                               
                                    Text("10 Seconds Up!!")
                                        .foregroundColor(Color.red)
                                        .onAppear() {
                                            
                                            self.wordTimeOver()
                                        }
                                
                            } else if gameQuestionTimer.mainGameTimerLimit == 0  {
                                
                                Text(self.gameOverMessage)
                                    .foregroundColor(Color.red)
                                    .onAppear() {
                                        
                                        //Game Over Status
                                        self.gameOverStatus = true
                                        
                                        //Set new game button
                                        self.showNewGameButton = true
                                        //Stop Question Timer
                                        self.gameQuestionTimer.deinstantiateQuestionTimer()
                                        
                                        //Stop Game Timer
                                        self.gameQuestionTimer.deinitialiseGameTimer()
                                        
                                        //Stop Game Music
                                        //stopBackgroundSound()
                                        
                                      
                                        
                                }
                                
                                
                            }
                            
                            
                             
                        }//End of ZStack
                    }//End of game status
                    
                    
                    
                    //Spacer().frame(height:20)
                    
                    
                    
                    
                    
                    if self.newRandomWord {
                        
                      
                        
                        
                        
                        
                        //Shuffled Random Letter
                        
                        //Spacer().frame(height:30)
                        
                        if showRandomLetters {
                        
                        Text("Random Word")
                            .font(.custom("Chalkboard SE", size: 25))
                            .foregroundColor(Color.gray).bold()
                            .transition(.slide)
                            .animation(.default)
                            
                        Spacer().frame(height:10)
                        HStack {
                            
                            RandomLetterSquare(inletter: self.randomFirstLetter)
                            RandomLetterSquare(inletter: self.randomSecondLetter)
                            RandomLetterSquare(inletter: self.randomThirdLetter)
                            RandomLetterSquare(inletter: self.randomFourthLetter)
                            RandomLetterSquare(inletter: self.randomFifthLetter)
                            
                            ZStack {
                                                               
                               //Score Bubble
                               
                               Rectangle()
                                   .frame(width:40,height: 40)
                                   .foregroundColor(Color.blue)
                                   .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                   .shadow(radius: 6)
                                
                                    if self.showCorrectScoreBubble {
                               
                                       Text("\(self.correctScoreBubble)")
                                               .foregroundColor(Color.yellow)
                                        .font(.system(size: 20)).bold()
                                        
                                        
                                    }
                               }
                        
                        
                                
                        }.transition(.slide)//End of Random HStack
                            .animation(.default)
                            
                        }//End Show Randome Letters
                        
                       
                        if self.showPickLetters {
                            
                        //Spacer().frame(height:30)
                        Text("Pick Letter")
                            .font(.custom("Chalkboard SE", size: 25))
                            .foregroundColor(Color.gray).bold()
                            .transition(.slide)
                            .animation(.default)
                        Spacer().frame(height:10)
                        
                       //Sorted Random Letter
                        HStack {
                            
                            SortedLetterSquare(inletter: self.playerSortedFirstLetter)
                                .onTapGesture {
                                    
                                    //Call Function playerOnTapAction
                                    self.playerOnTapAction(letterPlayed: self.playerSortedFirstLetter)
                                    
                                    //Speak Letter
                                    gameSpeech(word: self.playerSortedFirstLetter.lowercased())
                                    
                                   
                            }//End of TapGesture
                            
                            
                            SortedLetterSquare(inletter: self.playerSortedSecondLetter)
                                .onTapGesture {
                                    
                                        //Call Function playerOnTapAction
                                        self.playerOnTapAction(letterPlayed: self.playerSortedSecondLetter)
                                    
                                        //Speak Letter
                                        gameSpeech(word: self.playerSortedSecondLetter.lowercased())
                                    
                                }//End of TapGesture
                            
                            
                            SortedLetterSquare(inletter: self.playerSortedThirdLetter)
                                .onTapGesture {
                                    
                                    
                                        //Call Function playerOnTapAction
                                        self.playerOnTapAction(letterPlayed: self.playerSortedThirdLetter)
                                    
                                        //Speak Letter
                                        gameSpeech(word: self.playerSortedThirdLetter.lowercased())
                                    
                                }//End of TapGesture
                                
                            SortedLetterSquare(inletter: self.playerSortedFourthLetter)
                                .onTapGesture {
                                    
                                        //Call Function playerOnTapAction
                                        self.playerOnTapAction(letterPlayed: self.playerSortedFourthLetter)
                                    
                                        //Speak Letter
                                        gameSpeech(word: self.playerSortedFourthLetter.lowercased())
                                    
                                }//End of TapGesture
                            SortedLetterSquare(inletter: self.playerSortedFifthLetter)
                                .onTapGesture {
                                    
                                        //Call Function playerOnTapAction
                                        self.playerOnTapAction(letterPlayed: self.playerSortedFifthLetter)
                                    
                                        //Speak Letter
                                        gameSpeech(word: self.playerSortedFifthLetter.lowercased())
                                    
                                }//End of TapGesture
                            
                            
                                
                                
                                Button(action: {
                                    
                                  
                                    
                                    
                                }) {
                                
                                    ZStack {
                                        
                                    
                                            
                                                    Rectangle()
                                                        .frame(width:40,height: 40)
                                                        .foregroundColor(Color.blue)
                                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                                    
                                                        Text("⏎")
                                                            .foregroundColor(Color.yellow).bold()
                                                            .font(.system(size: 30))
                                                            .onTapGesture {
                                                                
                                                                if self.playedLetterOne != "" && self.playedLetterTwo != "" && self.playedLetterThree != "" && self.playedLetterFour != "" && self.playedLetterFive != "" {
                                                                    
                                                                    self.letterPlayedCompleted = true
                                                                    
                                                            
                                                                    
                                                                }
                                                                
                                                                if self.letterPlayedCompleted {
                                                                
                                                                self.acceptWord()
                                                                    
                                                                
                                                                } else {
                                                                    
                                                                    self.showAlertCompleteLetterEntry = true
                                                                }
                                                                
                                                                
                            
                                                                
                                                            }
                                                        .alert(isPresented: $showAlertCompleteLetterEntry) {
                                                            
                                                            Alert(title: Text("Incomplete Word Alert"), message: Text("Complete Word!!!"), dismissButton: .default(Text("OK"),action: {self.showAlertCompleteLetterEntry = false}))
                                                        }
                                        
                                                
                                               
                                        }//End of ZStack
                                
                                    
                                    
                            }//End of Button
                            
                        }//End of Sorted HStack
                            .transition(.slide)
                            .animation(.default)
                        
                        }
                        
                    } //End of New Random Word
                        
                    if self.playerSortedFirstLetter != "" || self.playerSortedSecondLetter != "" || self.playerSortedThirdLetter != "" || self.playerSortedFourthLetter != "" || self.playerSortedFifthLetter != "" {
                        
                        if self.showPickedLetters {
                        
                        //Spacer().frame(height:30)
                        Text("Picked Letters")
                            .font(.custom("Chalkboard SE", size: 25))
                            .foregroundColor(Color.gray).bold()
                            .transition(.slide)
                            .animation(.default)
                        
                        Group {
                                HStack {
                                    
                                    PlayedLetterSquare(inletter: self.playedLetterOne)
                                    PlayedLetterSquare(inletter: self.playedLetterTwo)
                                    PlayedLetterSquare(inletter: self.playedLetterThree)
                                    PlayedLetterSquare(inletter: self.playedLetterFour)
                                    PlayedLetterSquare(inletter: self.playedLetterFive)
                                    
                                   
                                   
                                    ZStack {
                                            Rectangle()
                                                .frame(width:40,height: 40)
                                                .foregroundColor(Color.blue)
                                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                            
                                                Text("X")
                                                    .foregroundColor(Color.yellow)
                                                    .font(.system(size: 30))
                                                   
                                                        
                                               
                                    
                                        .onTapGesture {
                                            if self.playedLetterFive != "" {
                                                self.playedLetterFive = ""
                                                gameAudioPlayerNormal(sound: "5LetterBackSpace", type: "mp3")
                                                
                                            } else if self.playedLetterFour != "" {
                                                self.playedLetterFour = ""
                                                gameAudioPlayerNormal(sound: "5LetterBackSpace", type: "mp3")
                                                
                                            } else if self.playedLetterThree != "" {
                                                self.playedLetterThree = ""
                                                gameAudioPlayerNormal(sound: "5LetterBackSpace", type: "mp3")
                                                
                                            } else if self.playedLetterTwo != "" {
                                                self.playedLetterTwo = ""
                                                gameAudioPlayerNormal(sound: "5LetterBackSpace", type: "mp3")
                                                
                                            } else if self.playedLetterOne != "" {
                                                self.playedLetterOne = ""
                                                gameAudioPlayerNormal(sound: "5LetterBackSpace", type: "mp3")
                                                
                                            }
                                    }//End of TapGesture
                                    
                                    }
                                    
                                }
                                .transition(.slide)
                                .animation(.default)
                            
                        }//End of Group
                        }
                        
                    } //End of New Random Word
                    
                    
                    Group {
                    
                                //Insert Game Logo
                                
                                if self.gameLogoImage {
                                    
                                    Spacer().frame(height:30)
                                    
                                    
                                    HStack {
                                        
                                        
                                        Spacer().frame(width:40)
                                        
                                        ZStack(alignment: .center) {
                                       
                                        
                                       
                                        
                                        Rectangle()
                                                .frame(width:230,height: 230)
                                                .foregroundColor(Color.clear)
                                                
                                            Image("Sun_GameLogo")
                                                .resizable()
                                                .frame(width:240,height: 240)
                                            
                                            Text("UfoSoft")
                                                .font(.custom("Gill Sans", size: 35))
                                                .foregroundColor(Color.gray)
                                        
                                        }
                                        
                                        
                                    }
                                    .transition(.slide)
                                    .animation(.default)
                                    
                                    
                                    
                                }//End of Game Logo
                        
                        
                            
                            
                   
                        
                        //Spacer().frame(height:30)
                        
                        VStack {
                            
                            if gameAlphabetIntro {
                                Spacer().frame(height:30)
                            
                                HStack(spacing: 37) {
                                   
                                    
                                    if self.showIntroLetterOne {
                                        
                                        AlphabetIntroTop(inletter: "A")
                                            .transition(.slide)
                                            .animation(.default)
                                    }
                                    
                                    if self.showIntroLetterThree {
                                        AlphabetIntroTop(inletter: "P")
                                            .transition(.slide)
                                            .animation(.default)
                                    }
                                    
                                    if self.showIntroLetterFive {
                                        
                                        AlphabetIntroTop(inletter: "A")
                                            .transition(.slide)
                                            .animation(.default)
                                    }
                                    
                                    if self.showIntroLetterSeven {
                                        
                                        AlphabetIntroTop(inletter: "E")
                                            .transition(.slide)
                                            .animation(.default)
                                    }
                                                                      
                                }//Alphabet Intro Top HStack
                            
                            HStack(spacing: 35) {
                                Spacer().frame(width:40)
                                
                                if self.showIntroLetterTwo {
                                    
                                    AlphabetIntroBottom(inletter: "L")
                                        .transition(.slide)
                                        .animation(.default)
                                }
                                
                                if self.showIntroLetterFour {
                                    
                                    AlphabetIntroBottom(inletter: "H")
                                        .transition(.slide)
                                        .animation(.default)
                                }
                                
                                if self.showIntroLetterSix {
                                    
                                    AlphabetIntroBottom(inletter: "B")
                                        .transition(.slide)
                                        .animation(.default)
                                }
                                
                                if self.showIntroLetterEight {
                                    
                                    AlphabetIntroBottom(inletter: "T")
                                        .transition(.slide)
                                        .animation(.default)
                                }
                                
                            }//Alphabet Intro Bottom HStack
                                
                            }
                        }
                        
                        
                        
                        
                        
                        //Spacer().frame(height:20)
                        
                        ZStack {
                                Rectangle()
                                    .frame(width:120,height: 50)
                                    .foregroundColor(Color.clear)
                           
                        
                        if self.showNewGameButton {
                        //New Game Question
                                Button(action: {
                                    
                                    //Set high Score
                                    self.highScore = self.correctScore
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    //Reset score to zero
                                    self.correctScore = 0
                                        
                                    }
                                    
                                    //Reset Correct Answer
                                    self.correctAnswerCount = 0
                                    
                                    
                                    //Reset variables
                                    self.wordTimeOver()
                                    
                                    //Instantiate game timer
                                    self.gameQuestionTimer.instantiateGameTimer()
                                    
                                    //Instantiate Question Timer
                                    self.gameQuestionTimer.instantiateQuestionTimer()
                                    
                                    //Reset game counter
                                    //self.gameQuestionTimer.mainGameTimerLimit = 300
                                    
                                    //Play background music
                                    gameAudioPlayerBackground(sound: "UfoSymphonyMultiBeat", type: "mp3")
                                    
                                    //Reset game new game button
                                    self.showNewGameButton = false
                                    
                                    
                                                                        
                                }) {
                                   
                                   Text("New Game ?")
                                    .frame(width:110,height: 35)
                                    .background(Color.purple)
                                    .foregroundColor(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                    .shadow(radius: 3)
                                    
                                    .onAppear() {
                                        if self.gameOverStatus {
                                            
                                            gameSpeech(word: "Game Over")
                                            
                                            
                                           
                                            
                                            //Adding an bonus points
                                            if self.processBonusPoint(inHighScore: self.highScore, currentGameScore: self.correctScore) > 0 {
                                                
                                                 DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                
                                                gameSpeech(word: "Congratulations you have beating you last high score \(self.highScore) and have been awarded \(self.processBonusPoint(inHighScore: self.highScore, currentGameScore: self.correctScore)) points")
                                                    
                                                
                                                }
                                                
                                                
                                                self.correctScore = self.correctScore + self.processBonusPoint(inHighScore: self.highScore, currentGameScore: self.correctScore)
                                                
                                                //Total final point
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                                    
                                                    gameSpeech(word: "Your total score is \(self.correctScore) points")
                                                }
                                                
                                                
                                                //New game
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                                                    
                                                    gameSpeech(word: "To play again click on new game. To exit click on exit button")
                                                }
                                                
                                            } else {
                                                
                                                gameSpeech(word: "Sorry, no bonus points have been awarded")
                                                
                                                //Game Player Score
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                                    
                                                    gameSpeech(word: "You got correct \(self.correctAnswerCount) and scored \(self.correctScore) points")
                                                    
                                                    
                                                }
                                                
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                                    
                                                    gameSpeech(word: "To play again click on new game. To exit click on exit button")
                                                }
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                        }//Game Status
                                        
                                    }//End of Appear
                                   
                                   
                               }
                    }//End of Show Button condition
                        
                        }
                        
                    
                    }//End of Group
                        
                        //Spacer().frame(height:10)
                        
                       
                    
        
                    
                    if showGameStats {
                        
                        VStack {
                            
                            HStack {
                    
                                    Text("Statistics /")
                                        .font(.custom("Courier", size: 20))
                                        .foregroundColor(Color.red)
                                        .onAppear() {
                                            
                                            self.playBackgroundMusic = true
                                            
                                            if self.playBackgroundMusic {
                                                
                                                gameAudioPlayerBackground(sound: "UfoSymphonyMultiBeat", type: "mp3")
                                            }
                                            
                                        }
                                        
                                    .onDisappear() {
                                        
                                        //Stop background music
                                        stopBackgroundSound()
                                        
                                        //Save Correct Score to UserDefaults
                                        self.highScore = self.correctScore
                                        
                                        //Reset score
                                        UserDefaults.standard.set(self.highScore, forKey: "HighScore")
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            
                                            self.correctScore = 0
                                        }
                                        
                                        
                                        self.gameOverMessage = ""
                                        
                                        self.gameAlphabetIntro = true
                                        
                                        //Make Alphabet Intro disapear
                                        if self.gameAlphabetIntro  {
                                            
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                                
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                self.showIntroLetterOne = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                self.showIntroLetterTwo = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                                self.showIntroLetterThree = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                                self.showIntroLetterFour = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                                self.showIntroLetterFive = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                                self.showIntroLetterSix = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                                self.showIntroLetterSeven = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                                self.showIntroLetterEight = true
                                                
                                                //Play Exit Sound
                                                gameAudioPlayerNormal(sound: "ExitSoundEffectOneSecond", type: "mp3")
                                            }
                                            
                                            
                                        }
                                        
                                        }//End of Game Stats onDisapear
                                
                                Text("High Score: \(self.highScore)")
                                    .font(.custom("Courier", size: 20))
                                    .foregroundColor(Color.blue)
                                
                            }
                            
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .frame(width:350,height: 60)
                                    .foregroundColor(.clear)
                                
                                
                                    VStack(alignment: .leading) {
                                        
                                        HStack(spacing: 200) {
                                            Text("Question Timer:")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.gray)
                                                
                                            Text("\(self.gameQuestionTimer.mainQuestionTimerLimit)")
                                            
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.red)
                                                
                                                .onAppear() {
                                                    
                                                    
                                                   
                                                    self.gameQuestionTimer.instantiateQuestionTimer()
                                                    
                                                    
                                                      
                                                    
                                                    
                                            }
                                                
                                         
                                                
                                                .onDisappear() {
                                                    
                                                    
                                                    self.gameQuestionTimer.deinstantiateQuestionTimer()
                                                
                                                                                                        
                                            }
                                                
                                                
                                          
                                        }//End of HStack
                                       
                                        
                                        HStack(spacing:200) {
                                            Text("Correct Answer:")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.gray)
                                            
                                            Text("\(self.correctAnswerCount)")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.blue)
                                            
                                        }
                                        
                                        HStack(spacing:264) {
                                            Text("Score:")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.gray)
                                                
                                            Text("\(self.correctScore)")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.init(red: 0.3, green: 0.5, blue: 0.7))
                                        }
                                        
                                        HStack(spacing: 221) {
                                        
                                        Text("Game Timer:")
                                            .font(.custom("Gill Sans", size: 15))
                                            .foregroundColor(Color.gray)
                                            
                                            
                                            
                                
                                            Text("\(self.gameQuestionTimer.mainGameTimerLimit)")
                                                .font(.custom("Gill Sans", size: 15))
                                                .foregroundColor(Color.purple)
                                                
                                                
                                                .onAppear() {
                                                        
                                                    self.gameQuestionTimer.instantiateGameTimer()
                                                        
                                                }
                                                    
                                                    .onDisappear() {
                                                        
                                                        self.gameQuestionTimer.deinitialiseGameTimer()
                                                    }
                                            
                                               
                                            
                                            
                                            }//End HStack for Game Timer
                                        
                                        
                                        
                                                
                                            
                                        
                                    }
                        
                            }//Stats ZStack
                            
                            
                                
                        }//End of Vstack for show Stats
                     
                                .transition(.slide)
                                .animation(.default)
                    }//End of Show Stats
                
                    
                    
                    }//End of VStack
                 
                    
                    
                
        }//End of ZStack
        
        
    }
    
}


//Tile Square model
struct RandomLetterSquare: View {
    
    var inletter = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack {
            
            Rectangle()
                .frame(width:40,height: 40)
                .foregroundColor(Color.green)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                .shadow(radius: 6)
            
                Text(inletter)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of RandomLetter model


//Tile Square model
struct SortedLetterSquare: View {
    
    var inletter = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack {
            
            Rectangle()
                .frame(width:40,height: 40)
                .foregroundColor(Color.orange)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                .shadow(radius: 6)
            
                Text(inletter)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of SorfedLetter model



//Tile Square model
struct PlayedLetterSquare: View {
    
    var inletter = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack {
            
            Rectangle()
                .frame(width:40,height: 40)
                .foregroundColor(Color.yellow)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                .shadow(radius: 6)
            
                Text(inletter)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of PlayedLetter model


//Alphabet Intro Top
struct AlphabetIntroTop: View {
    
    var inletter = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack {
            
            Rectangle()
                .frame(width:40,height: 40)
                .foregroundColor(Color.yellow)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                .shadow(radius: 6)
            
                Text(inletter).bold()
                    .foregroundColor(Color.gray)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of Alphabet Introduction Top




//Alphabet Intro Bottom
struct AlphabetIntroBottom: View {
    
    var inletter = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack {
            
            Rectangle()
                .frame(width:40,height: 40)
                .foregroundColor(Color.red)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                .shadow(radius: 6)
            
                Text(inletter).bold()
                    .foregroundColor(Color.yellow)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of Alphabet Introduction Bottom

