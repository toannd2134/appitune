
//
//  video.swift
//  Appitune
//
//  Created by Toan on 7/7/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Video{
    let count: Int
    let results: [MyVideo]

     required init?(_ json: JSON) {
        self.count = json["count"].intValue
        self.results = json["results"].arrayValue.map { MyVideo($0)! }
    }
}

class MyVideo {
    
    
    let artistName, trackName: String
    let previewURL: String
    let  artworkUrl100: String
    let  trackPrice: Double
  let country,primaryGenreName: String
   
    required init?(_ json : JSON) {
        self.artistName = json["artistName"].stringValue
        self.trackName = json["trackName"].stringValue
        self.previewURL = json["previewURL"].stringValue
        self.artworkUrl100 = json["artworkUrl100"].stringValue
        self.trackPrice = json["trackPrice"].doubleValue
         self.country = json["country"].stringValue
         self.primaryGenreName = json["primaryGenreName"].stringValue
        
    }
}

