//
//  Model.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 08.03.21.
//

import Foundation

class Model {
    func getVideos(){
        
        // Create a URL Object
        let url = URL(string: Constants.API_URL)
        //url in bos olmamasi icin guard yapiyoruz. bos ise else devreye girip return yapacak
        guard url != nil else{
            return
        }
        
        // Get a URLSession object
        
        let session = URLSession.shared
        
        
        // Get a data task from the URLSession object
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            
            // check if there were any errors
            // | option 7 ile yapiliyor ve || or anlamina geliyor
            if error != nil || data == nil{
                return
            }
            
            // Parsing the data into video objects
            
        
        }
        
        // Kick off the task
        
        dataTask.resume()
        
        
    }
    
}
