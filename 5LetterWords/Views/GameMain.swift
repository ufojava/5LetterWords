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
    
    
    //Set Question Timer
    @State private var normalTimeCounterState = true
    
    @State private var questionTimeCountdown = 10 // 10 seconds
    @State private var gameTimeLimit = 180
    @State private var questionTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //Set Game Timer
    @State private var gameTimeCounter = 300 //5 minues
    @State private var gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //New Game Button
    @State private var showNewGameButton = false
    
    
    
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
        
        
        //Reset Counter
        self.questionTimeCountdown = 10
        

        
        
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
        
        
        
    }//Ens Word Time Over
    
    
    
   
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
                
                //Play Correct Sount
                gameAudioPlayerNormal(sound: "CorrectSound", type: "mp3")
                
            
                //Add to the count
                self.correctAnswerCount += 1
                
                //Add Score
                self.correctScore += 20
                
            } else {
                
                gameAudioPlayerNormal(sound: "WrongAnswerSound", type: "mp3")
                
                
            }
            
            
        }
        
    }//End Process Answer
    
    
    
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
            
            
                .onDisappear() {
                    
                    //Stop Timers
                    self.questionTimer.upstream.connect().cancel() //Question Timer
                    self.gameTimer.upstream.connect().cancel() //Game Timer
                    
            }
        
                VStack {
                
                        Text("5cramble")
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
                            
                        Spacer().frame(height:40)
                        
                    Button(action: {
                        
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
                            
                            }
                       
                        
                        //Picked Letters
                    
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showPickedLetters.toggle()
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
                        
                        //Check if New game button is true
                        if self.showNewGameButton {
                            
                            self.showNewGameButton = false
                        }
                        
                        
                    }) {
                        
                        
                        Text("Begin / Close")
                            .frame(width:150,height: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.yellow)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                        .shadow(radius: 6)
                            
                    }
                    
                    Spacer().frame(height:20)
                    
                    if self.newRandomWord {
                        
                      
                        
                        
                        
                        
                        //Shuffled Random Letter
                        
                        Spacer().frame(height:30)
                        
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
                        
                        
                                
                        }.transition(.slide)//End of Random HStack
                            .animation(.default)
                            
                        }//End Show Randome Letters
                        
                       
                        if self.showPickLetters {
                            
                        Spacer().frame(height:30)
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
                                    
                                    
                                    //gameAudioPlayerNormal(sound: "ReturnKeySound", type: "mp3")
                                    
                                    if self.playedLetterOne != "" && self.playedLetterTwo != "" && self.playedLetterThree != "" && self.playedLetterFour != "" && self.playedLetterFive != "" {
                                        
                                        self.letterPlayedCompleted = true
                                        
                                    }
                                    
                                    if self.letterPlayedCompleted {
                                        
                                        
                                        self.getAllPlayedLetters = self.processPlayedLetters(inLetterOne: self.playedLetterOne, inLetterTwo: self.playedLetterTwo, inLetterThree: self.playedLetterThree, inLetterFour: self.playedLetterFour, inLetterFive: self.playedLetterFive)
                                        
                                        //Process correct answer
                                        self.processAnswer(inPlayedLetter: self.getAllPlayedLetters, inRandomWord: self.displayRandomWord)
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            
                                            self.resetForNewWord()
                                            self.getNewRandomWord()
                                            
                                            //Check for correct display
                                            if self.shuffledRandomWord == self.displayRandomWord {
                                                
                                                self.shuffledRandomWord = String(self.randomWord.shuffled())
                                            }
                                            
                                        }
                                    }
                                
                                    
                                }) {
                                
                            ZStack {
                                    
                                    Rectangle()
                                        .frame(width:40,height: 40)
                                        .foregroundColor(Color.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 2))
                                    
                                        Text("⏎")
                                            .foregroundColor(Color.yellow).bold()
                                            .font(.system(size: 30))
                                            
                            }
                            }//End of Button
                            
                        }//End of Sorted HStack
                            .transition(.slide)
                            .animation(.default)
                        
                        }
                        
                    } //End of New Random Word
                        
                    if self.playerSortedFirstLetter != "" || self.playerSortedSecondLetter != "" || self.playerSortedThirdLetter != "" || self.playerSortedFourthLetter != "" || self.playerSortedFifthLetter != "" {
                        
                        if self.showPickedLetters {
                        
                        Spacer().frame(height:30)
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
                        
                        Spacer().frame(height:30)
                        
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
                        
                        
                        
                        
                        
                        Spacer().frame(height:20)
                        
                        ZStack {
                                Rectangle()
                                    .frame(width:120,height: 50)
                                    .foregroundColor(Color.clear)
                           
                        
                        if self.showNewGameButton {
                        //New Game Question
                                Button(action: {}) {
                                   
                                   Text("New Game ?")
                                    .frame(width:110,height: 40)
                                    .background(Color.purple)
                                    .foregroundColor(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                                    .shadow(radius: 3)
                                   
                                   
                               }
                    }//End of Show Button condition
                        
                        }
                        
                    
                    }//End of Group
                        
                        Spacer().frame(height:20)
                        
                       
                    
                    
                    
                   // Spacer().frame(height:20)
                    
                    if showGameStats {
                        
                        VStack {
                    
                        Text("Game Statistics")
                            .font(.custom("Courier", size: 25))
                            .foregroundColor(Color.red)
                            .onAppear() {
                                
                                self.playBackgroundMusic = true
                                
                                if self.playBackgroundMusic {
                                    
                                    gameAudioPlayerBackground(sound: "UfoSymphonyMultiBeat", type: "mp3")
                                }
                                
                            }
                            
                        .onDisappear() {
                            
                            
                            self.gameAlphabetIntro = true
                            
                            //Make Alphabet Intro disapear
                            if self.gameAlphabetIntro  {
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.showIntroLetterOne = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.showIntroLetterTwo = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    self.showIntroLetterThree = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    self.showIntroLetterFour = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                    self.showIntroLetterFive = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                    self.showIntroLetterSix = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                    self.showIntroLetterSeven = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                    self.showIntroLetterEight = true
                                }
                                
                                //Stop Music after alphabets are in place
                                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                  
                                    stopBackgroundSound()
                                    
                                }
                            }
                            
                            }
                            
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .frame(width:350,height: 70)
                                    .foregroundColor(.clear)
                                
                                
                                    VStack(alignment: .leading) {
                                        
                                        HStack(spacing: 175) {
                                            Text("Question Timer:")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.gray)
                                                
                                            Text("\(self.questionTimeCountdown)")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.red)
                                                .onReceive(questionTimer) { qTime in
                                                    
                                                    if self.questionTimeCountdown > 0 {
                                                        
                                                        //Text("")
                                                        
                                                        self.questionTimeCountdown -= 1
                                                        
                                                        //Reset Word
                                                        if self.questionTimeCountdown == 0 {
                                                            
                                                            self.wordTimeOver()
                                                            gameSpeech(word: "10 Seconds Up")
                                                        }
                                                        
                                                    }
                                                    
        
                                                    
                                            }
                                            
                                            
                                          
                                        }
                                        
                                        HStack(spacing:173) {
                                            Text("Correct Answer:")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.gray)
                                            
                                            Text("\(self.correctAnswerCount)")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.blue)
                                            
                                        }
                                        
                                        HStack(spacing:259) {
                                            Text("Score:")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.gray)
                                                
                                            Text("\(self.correctScore)")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.init(red: 0.3, green: 0.5, blue: 0.7))
                                        }
                                        
                                        HStack(spacing: 205) {
                                        
                                        Text("Game Timer:")
                                            .font(.custom("Gill Sans", size: 20))
                                            .foregroundColor(Color.gray)
                                    
                                            Text("\(self.gameTimeCounter)")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.purple)
                                                
                                        
                                            
                                                
                                                .onReceive(gameTimer) {gTime in
                                                    
                                                    
                                                    if self.gameTimeCounter > 0 {
                                                        
                                                        self.gameTimeCounter -= 1
                                                        
                                                        
                                                        
                                                        
                                                    } else if self.gameTimeCounter == 0 {
                                                        
                                                        
                                                        //Stop Timers
                                                        self.questionTimer.upstream.connect().cancel() //Question Timer
                                                        self.gameTimer.upstream.connect().cancel() //Game Timer
                                                        
                                                        //Stop background music
                                                        stopBackgroundSound()
                                                        
                                                        //Announce to player total score from game
                                                        gameSpeech(word: "Game Over. ")
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                            gameSpeech(word: "you got \(self.correctAnswerCount) right and your total score is \(self.correctScore)")
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                                                
                                                                self.showNewGameButton = true
                                                            }
                                                        
                                                        }
                                                    
                                                    }
                                                    
                                                    
                                            }//End on Receive
                                                
                                            
                                            
                                            
                                            
                                            
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

