//
//  GameSound.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 01/05/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

//This file is responsible for Speech and Audio File Play
import Foundation
import AVFoundation




//Variables for Background and Normal Sound Effects
var gameNormalAudio: AVAudioPlayer?
var backgroundAuio: AVAudioPlayer?




//Function For Speech
func gameSpeech(word:String) {
    
    //Create utternace variable
    let utternace = AVSpeechUtterance(string: word)
    
    //Voice to be used
    utternace.voice = AVSpeechSynthesisVoice(language: "en-GB")
    
    //Voice Speed rate
    utternace.rate = 0.5
    
    //Synthersizer
    let voiceSynthersizer = AVSpeechSynthesizer()
    
    //use Speech
    voiceSynthersizer.speak(utternace)
    
}



//Function to play normal sound
func gameAudioPlayerNormal(sound:String,type:String) {
    
    
    //Set path to media file
    if let filePathLocation = Bundle.main.path(forResource: sound, ofType: type) {
        
        
        //Do Action
        
        do {
            
            
            gameNormalAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePathLocation))
            
            gameNormalAudio?.play()
            
            
            
        //Catch file media file not found
        } catch {
            
            
            print("File not found")
            
        }
    
        
        
    }
    
    
    
}//End of Player for normal sound



//Function to play background audio
func gameAudioPlayerBackground(sound:String,type:String) {
    
    
    //set path for media file
    if let filePathLocation = Bundle.main.path(forResource: sound, ofType: type) {
        
        
        //Do Action
        do {
            
            backgroundAuio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePathLocation))
            
            backgroundAuio?.play()
            backgroundAuio?.numberOfLoops = -1
            backgroundAuio?.volume = 0.4
            
            
                       
        } catch {
            
            print("File not found")
            
        }
        
        
        
    }
    
    
}//End of player for backgound


//Function to Stop Background Audio
func stopBackgroundSound() {
    
    backgroundAuio?.stop()
    
}//End of Stop background music



//Function to Stop Background Audio
func stopMainSound() {
    
    gameNormalAudio?.stop()
    
}//End of Stop background music


