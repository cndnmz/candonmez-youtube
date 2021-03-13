//
//  VideoTableViewCell.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 13.03.21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ v:Video) {
        
        self.video = v
        
        //Ensure that we have a video
        guard self.video != nil else {
            return
        }
        
        // Set the title
        
        self.titleLabel.text = video?.title
        
        
        // #Set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        
        // Check cache before downloading the data
        if let cachedData =  CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set the thumbnail imageview
            
            self.thumbnailImageView.image = UIImage(data: cachedData)
        }
        
        
        //Download the thumbnail data
        
        let url = URL(string: self.video!.thumbnail)
        
        //Get the shared URL Session object
        let session = URLSession.shared
        
        //Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // SAve the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                //check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                
                if url!.absoluteString != self.video?.thumbnail {
                    
                    //vide cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                //Create the image object
                let image = UIImage(data: data!)
                
                //Set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        // start data task
        dataTask.resume()
    }
    
}
