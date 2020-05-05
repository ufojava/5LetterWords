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
    
    
    //Set Timer
    @State private var questionTimeCountdown = 10
    @State private var gameTimeLimit = 180
    @State private var questionTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
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
                    
            }
        
                VStack {
                
                        Text("5cramble")
                            .font(.largeTitle).foregroundColor(Color.red).bold()
                    
                            .onAppear() {
                                
                                self.gameLogoImage = true
                    }
                            
                        Spacer().frame(height:40)
                        
                    Button(action: {
                        
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
                        
                        Spacer().frame(height:40)
                        
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
                            
                        Spacer().frame(height:40)
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
                        
                        Spacer().frame(height:40)
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
                                    
                                    Spacer().frame(height:40)
                                    
                                    
                                    HStack {
                                        
                                        
                                        Spacer().frame(width:40)
                                        
                                        ZStack(alignment: .center) {
                                       
                                        
                                       
                                        
                                        Rectangle()
                                                .frame(width:230,height: 230)
                                                .foregroundColor(Color.clear)
                                                
                                            Image("Sun_GameLogo")
                                                .resizable()
                                                .frame(width:240,height: 240)
                                            
                                            Text("Alphabets")
                                                .font(.custom("Gill Sans", size: 35))
                                                .foregroundColor(Color.gray)
                                        
                                        }
                                        
                                        
                                    }
                                    .transition(.slide)
                                    .animation(.default)
                                    
                                    
                                    
                                }
                
                    
                    }//End of Group
                        
                        Spacer().frame(height:40)
                        
                    
                    
                    
                    
                    Spacer().frame(height:30)
                    
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
                            
                            stopBackgroundSound()
                            
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
                                                .foregroundColor(Color.blue)
                                                .onReceive(questionTimer) { qTime in
                                                    
                                                    if self.questionTimeCountdown > 0 {
                                                        
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
                                                .foregroundColor(Color.blue)
                                        }
                                        
                                        HStack(spacing: 205) {
                                        
                                        Text("Game Timer:")
                                            .font(.custom("Gill Sans", size: 20))
                                            .foregroundColor(Color.gray)
                                        
                                        Text("12:00")
                                                .font(.custom("Gill Sans", size: 20))
                                                .foregroundColor(Color.blue)
                                        }
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
