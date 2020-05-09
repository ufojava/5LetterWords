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
        
        NavigationView {//
        
        //TextManipulation()
        TimerText()
        
        }//
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


//Struct to test timer

struct TimerText: View {
    
    @State private var timeCounter = 30
    @State private var countTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    
    
    var body: some View {
        
        
        VStack {
        
        Text("Count Timer")
            .onReceive(countTimer) { myTime in
                
                
                self.timeCounter -= 1
                
                
                
                
        }//End of OnReceive
           
            Text("\(self.timeCounter)")
            
        
       /*
        Text("\(self.timeCounter)")
            
            Button(action: {
                
                if self.timeCounter < 0 {
                    
                    self.timeCounter = 20
                    
                }
                
                
                
            }) {
                
                
                
                Text("Check Counter")
                
                
            }
        */
        
        }
        
        
    }
    
    
}



