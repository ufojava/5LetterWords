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
    
    
    //Played Letters
    @State private var showPlayedLetters = false
    
    //Played Letters One
    @State private var playedLetterOne = ""
    @State private var playedLetterOneState = false
    
    //Played Letters Two
    @State private var playedLetterTwo = ""
    @State private var playedLetterTwoState = false
    
    //Played Letters Three
    @State private var playedLetterThree = ""
    @State private var playedLetterThreeState = false
    
    //Played Letters Four
    @State private var playedLetterFour = ""
    @State private var playedLetterFourState = false
    
    //Played Letters Five
    @State private var playedLetterFive = ""
    @State private var playedLetterFiveState = false

    
    
    
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


    
    
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            //Set background
            LinearGradient(gradient: Gradient(colors: [.blue, .white,.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        
                VStack {
                
                        Text("5 Letter Scramble")
                            .font(.largeTitle)
                            
                        Spacer().frame(height:40)
                        
                    Button(action: {
                        
                        self.newRandomWord.toggle()
                        self.randomWord = self.getRandomWord()
                        
                        //Holder Variable for Random word generator
                        self.displayRandomWord = self.randomWord
                       
                        
                        //For Players
                        self.sortedRandomWord = String(self.displayRandomWord.sorted())
                        self.shuffledRandomWord = String(self.randomWord.shuffled())
                        
                        //Run Index for Random word
                        self.extractRandomWordChar(inRandomWord: self.shuffledRandomWord)
                        
                        //Run index for Sorted word
                        self.extractPlayerSortedChar(inSortedWord: self.sortedRandomWord)
                    
                       
                        
                        
                        
                    }) {
                        
                        
                        Text("Get Word")
                            .frame(width:100,height: 30)
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black,lineWidth: 1))
                            
                    }
                    
                    Spacer().frame(height:30)
                    
                    if self.newRandomWord {
                        
                      
                        
                        
                        //Text("To be hidden: \(self.displayRandomWord)")
                        //Text("For Tiles: \(self.shuffledRandomWord)")
                        
                        //Shuffled Random Letter
                        
                        Spacer().frame(height:40)
                        Text("Random Word")
                            .font(.custom("Chalkboard SE", size: 25))
                        Spacer().frame(height:10)
                        HStack {
                            
                            RandomLetterSquare(inletter: self.randomFirstLetter)
                            RandomLetterSquare(inletter: self.randomSecondLetter)
                            RandomLetterSquare(inletter: self.randomThirdLetter)
                            RandomLetterSquare(inletter: self.randomFourthLetter)
                            RandomLetterSquare(inletter: self.randomFifthLetter)
                        
                        
                        }//End of Random HStack
                        
                        
                       
                        
                        Spacer().frame(height:40)
                        Text("Player Letters Pad")
                            .font(.custom("Chalkboard SE", size: 25))
                        Spacer().frame(height:10)
                        
                       //Sorted Random Letter
                        HStack {
                            
                            SortedLetterSquare(inletter: self.playerSortedFirstLetter)
                                .onTapGesture {
                                    if self.playedLetterOne == "" {
                                        
                                        self.playedLetterOne = self.playerSortedFirstLetter
                                        
                                    } else if self.playedLetterTwo == "" {
                                        
                                        self.playedLetterTwo = self.playerSortedFirstLetter
                                        
                                    } else if self.playedLetterThree == "" {
                                        
                                        self.playedLetterThree = self.playerSortedFirstLetter
                                        
                                    } else if self.playedLetterFour == "" {
                                        
                                        self.playedLetterFour = self.playerSortedFirstLetter
                                        
                                    } else if self.playedLetterFive == "" {
                                        
                                        self.playedLetterFive = self.playerSortedFirstLetter
                                    }
                            }//End of TapGesture
                            
                            
                            SortedLetterSquare(inletter: self.playerSortedSecondLetter)
                                .onTapGesture {
                                        if self.playedLetterOne == "" {
                                            
                                            self.playedLetterOne = self.playerSortedSecondLetter
                                            
                                        } else if self.playedLetterTwo == "" {
                                            
                                            self.playedLetterTwo = self.playerSortedSecondLetter
                                            
                                        } else if self.playedLetterThree == "" {
                                            
                                            self.playedLetterThree = self.playerSortedSecondLetter
                                            
                                        } else if self.playedLetterFour == "" {
                                            
                                            self.playedLetterFour = self.playerSortedSecondLetter
                                            
                                        } else if self.playedLetterFive == "" {
                                            
                                            self.playedLetterFive = self.playerSortedSecondLetter
                                        }
                                }//End of TapGesture
                            
                            
                            SortedLetterSquare(inletter: self.playerSortedThirdLetter)
                                .onTapGesture {
                                        if self.playedLetterOne == "" {
                                            
                                            self.playedLetterOne = self.playerSortedThirdLetter
                                            
                                        } else if self.playedLetterTwo == "" {
                                            
                                            self.playedLetterTwo = self.playerSortedThirdLetter
                                            
                                        } else if self.playedLetterThree == "" {
                                            
                                            self.playedLetterThree = self.playerSortedThirdLetter
                                            
                                        } else if self.playedLetterFour == "" {
                                            
                                            self.playedLetterFour = self.playerSortedThirdLetter
                                            
                                        } else if self.playedLetterFive == "" {
                                            
                                            self.playedLetterFive = self.playerSortedThirdLetter
                                        }
                                }//End of TapGesture
                                
                            SortedLetterSquare(inletter: self.playerSortedFourthLetter)
                                .onTapGesture {
                                        if self.playedLetterOne == "" {
                                            
                                            self.playedLetterOne = self.playerSortedFourthLetter
                                            
                                        } else if self.playedLetterTwo == "" {
                                            
                                            self.playedLetterTwo = self.playerSortedFourthLetter
                                            
                                        } else if self.playedLetterThree == "" {
                                            
                                            self.playedLetterThree = self.playerSortedFourthLetter
                                            
                                        } else if self.playedLetterFour == "" {
                                            
                                            self.playedLetterFour = self.playerSortedFourthLetter
                                            
                                        } else if self.playedLetterFive == "" {
                                            
                                            self.playedLetterFive = self.playerSortedFourthLetter
                                        }
                                }//End of TapGesture
                            SortedLetterSquare(inletter: self.playerSortedFifthLetter)
                                .onTapGesture {
                                        if self.playedLetterOne == "" {
                                            
                                            self.playedLetterOne = self.playerSortedFifthLetter
                                            
                                        } else if self.playedLetterTwo == "" {
                                            
                                            self.playedLetterTwo = self.playerSortedFifthLetter
                                            
                                        } else if self.playedLetterThree == "" {
                                            
                                            self.playedLetterThree = self.playerSortedFifthLetter
                                            
                                        } else if self.playedLetterFour == "" {
                                            
                                            self.playedLetterFour = self.playerSortedFifthLetter
                                            
                                        } else if self.playedLetterFive == "" {
                                            
                                            self.playedLetterFive = self.playerSortedFifthLetter
                                        }
                                }//End of TapGesture
                            
                            
                        }//End of Sorted HStack
                        
                        
                    } //End of New Random Word
                        
                    if self.playerSortedFirstLetter != "" || self.playerSortedSecondLetter != "" || self.playerSortedThirdLetter != "" || self.playerSortedFourthLetter != "" || self.playerSortedFifthLetter != "" {
                        
                    
                        Spacer().frame(height:40)
                        Text("Played Letters")
                            .font(.custom("Chalkboard SE", size: 25))
                        
                        Group {
                        HStack {
                            
                            PlayedLetterSquare(inletter: self.playedLetterOne)
                            PlayedLetterSquare(inletter: self.playedLetterTwo)
                            PlayedLetterSquare(inletter: self.playedLetterThree)
                            PlayedLetterSquare(inletter: self.playedLetterFour)
                            PlayedLetterSquare(inletter: self.playedLetterFive)
                            PlayedLetterSquare(inletter: "🔙")
                                .onTapGesture {
                                    if self.playedLetterFive != "" {
                                        self.playedLetterFive = ""
                                        
                                    } else if self.playedLetterFour != "" {
                                        self.playedLetterFour = ""
                                        
                                    } else if self.playedLetterThree != "" {
                                        self.playedLetterThree = ""
                                        
                                    } else if self.playedLetterTwo != "" {
                                        self.playedLetterTwo = ""
                                        
                                    } else if self.playedLetterOne != "" {
                                        self.playedLetterOne = ""
                                        
                                    }
                            }//End of TapGesture
                            
                            
                            
                            
                            
                        }
                        }
                       
                        
                    } //End of New Random Word
                    }
                 
                    
                    
                
        }
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
            
                Text(inletter)
                    .foregroundColor(Color.blue)
                    .font(.system(size: 30))
            }
            
            
        }
        
        
    }
    
}//End of PlayedLetter model
