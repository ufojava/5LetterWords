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
    
    //Function to get random word
    func getRandomWord() -> String {
        
        let wordDictionary = fiveLetterDictionary.datastructure
        
        let randomWord = wordDictionary.randomElement()!
        
        print(randomWord.word)
        
        
        return randomWord.word
        
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
                       
                        
                        
                        
                    }) {
                        
                        
                        Text("Get Random Word")
                    }
                    
                    if self.newRandomWord {
                        
                        Text("Normal: \(self.randomWord)")
                        Text("Sorted \(self.sortedRandomWord)")
                        
                       
                        
                        
                        //Sort the string
                        
                    }
                    
                 
                    
                    
                }
        }
    }
    
}
