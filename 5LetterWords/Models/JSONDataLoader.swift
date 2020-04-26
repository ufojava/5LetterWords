//
//  JSONDataLoader.swift
//  5LetterWords
//
//  Created by Ufuoma Okoro on 26/04/2020.
//  Copyright © 2020 Ufuoma Okoro. All rights reserved.
//

/*
JSON File DatatLoader
File name - 5LetterEasyDic.JSON
*/
 
 import Foundation



public class DataLoader: ObservableObject {
    
    @Published var datastructure = [DictionaryStructure]()







                        //Function to decode JSOn File
                        func decodeJSONFile() {
                            
                            //File Location for impoer
                            
                            if let fileLocation = Bundle.main.url(forResource: "5LetterEasyDic", withExtension: "json") {
                                
                                //Use Do to prevent crash
                                
                                    do {
                                        
                                        //Define Data
                                        let data = try Data(contentsOf: fileLocation)
                                        
                                        
                                        //Use Decodef
                                        let jsonDecode = JSONDecoder()
                                        
                                        
                                        //Decode JSON Data
                                        let dataFRomJSONFIle = try jsonDecode.decode([DictionaryStructure].self, from: data)
                                        
                                        
                                        //Time to allow the data to load
                                        DispatchQueue.main.async {
                                            
                                            self.datastructure = dataFRomJSONFIle

                                            
                                        }//End from Async
                                        
                                        
                                        
                                    } catch {
                                    
                                    //Print any errors
                                    print(error)
                                    
                                    
                                    
                                    
                                    
                                }//Catch Closure
                                
                                } //File Location
                            

                            
                            
                        }//End of Function

}//End of class

