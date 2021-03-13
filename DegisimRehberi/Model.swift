//
//  Model.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 08.03.21.
//

// kodun belli bolumunu bitirince gitgun a atmak icin
//git add .
//git commit -m "buraya comment yaz"
//git push origin master
//bunlari terminalde yazinca kodlari github da master branch icine push ediyor. oradan da bitrise zaten otomatik aliyor. 

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos:[Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    
    func getVideos(){
        
        // Create a URL Object
        let url = URL(string: Constants.API_URL)
        //url in bos olmamasi icin guard yapiyoruz. bos ise else devreye girip return yapacak
        guard url != nil
        else{
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
            do{
                
                // Parsing the data into video objects
                let decoder = JSONDecoder()
                //tum video.swift i kodladik en son da gelip buraya bir decoder actik. o datalari buraya cekecegiz
                
                decoder.dateDecodingStrategy = .iso8601
                //Date decode ederken standart format olarak bu iso yu kullanacak onu tanimladik
                
                let response = try decoder.decode(Response.self, from: data!)
                
                
                if response.items != nil {
                    
                    DispatchQueue.main.async {
                        // Call the "videosReturned" method of the delegate
                            self.delegate?.videosFetched(response.items!)
                    }
                
               
                }
                    
                //dump(response)
            }

            catch{
                
            }
            
 // do catch bir error kontrol sistemi. icinde try olmasinin sebebi de bu.
        
        }
        
        // Kick off the task
        
        dataTask.resume()
        
        
    }
    
}
