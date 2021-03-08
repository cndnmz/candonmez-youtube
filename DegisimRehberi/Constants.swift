//
//  Constants.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 08.03.21.
//

import Foundation

struct Constants {
    
 
    static var API_KEY = "AIzaSyANNnv8QHpRjox3VqtXvwvUzRFH8dHQPYg"
   // static var PLAYLIST_ID = "PLU6ixkJyxZir0jsscF-SeEmewG2N0FnMQ"
    
    static var PLAYLIST_ID = "PLf1y-ELWKX-fvb0LD9Rf2fnbVNn5WFdS0"
    static var API_URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    
}


