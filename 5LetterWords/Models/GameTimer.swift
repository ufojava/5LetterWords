//
//  GameTimer.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 10/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//Modal for timer
import SwiftUI
import Combine




//Game Timer
class GameTimer: ObservableObject {
    
    @Published var globalGameTimeLimit = 0
    
    private var subscriber: AnyCancellable?
    
    //Function initiate Timer
    func instantiaiteGameTime() {
        
        self.globalGameTimeLimit = 300
        self.subscriber = Timer
               .publish(every: 1, on: .main, in: .common)
               .autoconnect()
               .sink(receiveValue: { _ in
                
                if self.globalGameTimeLimit > 0 {
                    
                   self.globalGameTimeLimit -= 1
                    
                } else if self.globalGameTimeLimit <= 0 {
                    
                    gameSpeech(word: "Game Over")
                    
                }
               })
    
                    
    }
    
    //Function to to cancel Timer
    func deinstantiateGameTime() {
        
        self.subscriber = nil
    }
    
    
    
    
}//End of Game Timer Class



//Class for Question Timer
class QuestionTimer: ObservableObject {
    
    @Published var globaQuestionTimeLimt = 0
    
    private var subscriber: AnyCancellable?
    
    //Function intiate Timer
    func instantiateQuestionTimer() {
        
        self.globaQuestionTimeLimt = 10
        self.subscriber = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                
                
                if self.globaQuestionTimeLimt > 0 {
                
                self.globaQuestionTimeLimt -= 1
                    
                } else if self.globaQuestionTimeLimt <= 0 {
                    
                    gameSpeech(word: "10 seconds up")
                    self.globaQuestionTimeLimt = 10
                    
                }
                
            })
        
    }//End of Initialise function
    
    
    //Function to cancel timer
    func deinstantiateQuestionTimer() {
        
        self.subscriber = nil
        
    }
    
    
    
}//End of Question Timer Class
