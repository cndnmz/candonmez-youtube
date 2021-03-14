//
//  Video.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 08.03.21.
//

import Foundation

struct Video:Decodable {
    //Decodable diyerek bu structure json dan decode edecek ve init ile tanimladigimiz initializer icine bu bilgiyi parse edecek.
    //init icinde ise bunu nasil yapcagini tanimlayacagiz
 
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    
    enum CodingKeys: String, CodingKey {
        
        //published de tanimd yapmak zorunda kaldik ve bu String oldugu icin coding keys i de string yaptik
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt"
        case title
        //key adi json da ve variable da yukarida yani ayni oldugu icin bir daha tanim yapmadik
        case description
        case thumbnail = " url"
        //url thumbnails altinda high keyi altinda bu nedenle onlari da tanimlamaliyiz
        case videoId
        //videID de resourceID altinda onu da tanimlayacagiz
       
        
        // all the keys we are interested in is under snippet key
        
        
        
        
    }
    
    init (from decoder:Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //ana konteyner belirledik burada tüm datalar var
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        //alt konteyner olarak ana konteynar icinde snippet i belirledik. nested container ana konteyner altinda icinde value olanlari tanimlamak icin gerekiyor.
        
        //Parse title
        
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        //Parse description
        
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        //Parse the publish date
        
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        //Parse thumbnails
        
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        //Parse videoID
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
    }
    
}
