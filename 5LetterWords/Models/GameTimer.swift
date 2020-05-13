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



//Game & Quetion Timer
class GameQuestionTimer: ObservableObject {
    
    //Published Variables
    @Published var mainGameTimerLimit = 1
    @Published var mainQuestionTimerLimit = 1
    
    //Subscribers
    private var gameSubscriber: AnyCancellable?
    private var questionSubscriber: AnyCancellable?
    
    
    //Function to initialise Game Timer
    func instantiateGameTimer() {
        
        self.mainGameTimerLimit = 300
        self.gameSubscriber = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                
                if self.mainGameTimerLimit > 0 {
                    
                    self.mainGameTimerLimit -= 1
                    
                    if self.mainGameTimerLimit > 0 && self.mainGameTimerLimit <= 10 {
                        
                        //Stop backgroud music
                        stopBackgroundSound()
                        
                        //Play 10 second countdown
                        gameAudioPlayerNormal(sound: "TenSecondCountDown", type: "mp3")
                        
                        
                        
                        
                    }
                    
                }
                
                
            })
        
        
        
            
        
    }//End Initialise Game
    
    //Function De-initilise Game Timer
    func deinitialiseGameTimer() {
        
        self.gameSubscriber = nil
    }
    
    
    //Function to initialise Question Timer
    func instantiateQuestionTimer() {
        
        self.mainQuestionTimerLimit = 10
        self.questionSubscriber = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                
                if self.mainQuestionTimerLimit > 0 {
                    
                    self.mainQuestionTimerLimit -= 1
                    
                    
                } else if self.mainQuestionTimerLimit == 0 {
                    
                    gameSpeech(word: "10 seconds up")
                    self.mainQuestionTimerLimit = 10
                    
                }
                
            })
        
        
        
    }//End Initialise Question
    
    //Function to De-initialise Question Timer
    func deinstantiateQuestionTimer() {
        
        self.questionSubscriber = nil
        
        
    }
    
    
}//End of Game and Question Class





