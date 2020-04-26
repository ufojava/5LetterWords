//
//  DictionaryStructure.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 26/04/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//


//Dicitonary Data Structure
import Foundation


struct DictionaryStructure: Codable {
    
    public var id: Int
    
    var word: String
    
}

//Observable Object - I should be able to use this variable around the project
class Letter: ObservableObject {
    
    @Published var word = ""
}
