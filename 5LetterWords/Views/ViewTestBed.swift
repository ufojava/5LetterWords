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
    
    @State private var changeTextOrder = false
    
    
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
        
        VStack {
        
        Text("Place Holder")
            
        
         
            Button(action: {
                
                self.changeTextOrder = true
                
                self.sortedString = String(self.myText.sorted())
                
                
                
                
            }) {
                
                Text("Change Text Order")
                
            }
            
            Text("Revised Text is: \(self.sortedString) ")
        
            
            }
            
        }//ZSack
    }
    
}
