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
    @State private var sortedRandomWord = ""
    
    
    //Random Word Letters
    @State private var randomFirstLetter = ""
    @State private var randomSecondLetter = ""
    @State private var randomThirdLetter = ""
    @State private var randomFourthLetter = ""
    @State private var randomFifthLetter = ""
    
    
    
    //Function to get random word
    func getRandomWord() -> String {
        
        let wordDictionary = fiveLetterDictionary.datastructure
        
        let randomWord = wordDictionary.randomElement()!
        
        print(randomWord.word)
        
        
        return randomWord.word
        
    }
    
    
    //Process random word to get character
    func extractChar(inRandomWord:String) {
        
        
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


    
    
    
    var body: some View {
        
        
        ZStack {
            
            //Set background
            LinearGradient(gradient: Gradient(colors: [.blue, .white,.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        
                VStack {
                
                        Text("5 Letter Dictionary")
            
                        
                    Button(action: {
                        
                        self.newRandomWord.toggle()
                        self.randomWord = self.getRandomWord()
                        self.sortedRandomWord = String(self.randomWord.sorted())
                        
                        //Run Index
                        self.extractChar(inRandomWord: self.sortedRandomWord)
                    
                       
                        
                        
                        
                    }) {
                        
                        
                        Text("Get Random Word")
                    }
                    
                    if self.newRandomWord {
                        
                        Text("Normal: \(self.randomWord)")
                        Text("Sorted \(self.sortedRandomWord)")
                        
                        //Display letters
                        Text("First Letter: \(self.randomFirstLetter)")
                        Text("Second Letter: \(self.randomSecondLetter)")
                        Text("Third Letter: \(self.randomThirdLetter)")
                        Text("Fourth Letter: \(self.randomFourthLetter)")
                        Text("Fifth Letter: \(self.randomFifthLetter)")
                        
                       
                        
                        
                        //Sort the string
                        
                    }
                    
                 
                    
                    
                }
        }
    }
    
}
