//
//  ViewTestBed.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 26/04/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//Game Test Bed
import SwiftUI



struct GameTestBed: View {
    
    var body: some View {
        
        TextManipulation()
        
        
    }
    
}



struct GameTestBed_Prevview: PreviewProvider {
    
    static var previews: some View {
        
        GameTestBed()
        
        
    }
}


struct TextManipulation: View {
    
    @State private var myText = "CLIMB"


    
    
    @State private var sortedString = ""
    @State private var shuffledString = ""
    
    @State private var changeTextOrder = false
    

    //funciton to get character index
    func getChar() -> String {
        
        
        let myCharacter = String(self.myText[myText.index(after: myText.startIndex)])
        
        
        return myCharacter
        
    }
    
    
    
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
        
        VStack {
        
        Text("Place Holder")
            
        
         
            Button(action: {
                
                self.changeTextOrder = true
                
                self.sortedString = String(self.myText.sorted())
                self.shuffledString = String(self.myText.shuffled())
                
                
                
                
            }) {
                
                Text("Change Text Order")
                
            }
            
            Text("Revised Text is: \(self.sortedString) ")
            Text("Shuffled Text is \(self.shuffledString)")
            Text("My  Character is: \(self.getChar())")
        
            
            }
            
        }//ZSack
    }
    
}
