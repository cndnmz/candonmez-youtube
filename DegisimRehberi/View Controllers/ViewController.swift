//
//  ViewController.swift
//  DegisimRehberi
//
//  Created by Can Dönmez on 07.03.21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    //virgullerden sonra protokol eklemis oluyoruz
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    var model = Model()
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // set itself as the datasource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set itself as the delegate of the model
        model.delegate = self
        
        model.getVideos()
        
    }
    
    // MARK: - Model Delegate Methods
    
    func videosFetched(_ videos: [Video]) {
        //Set the returned videos to our video property
        self.videos = videos
        
        
        //Refresh the property
        tableView.reloadData()
    }
    
    // MARK: - TableView Methods
    //bu sekilde mark koyunca uste bir seperation cizgisi cekiyor ve kod viewda sagda ustte de gorunuyor
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
        //kac row oldugunu sayacak sonra bunu ne yapsin diye asagida belirleyecegiz
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as!
            VideoTableViewCell
        //configure the cell with the data
        
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        //return the cell
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    

}

