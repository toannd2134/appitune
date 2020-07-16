


//
//  TableViewCell.swift
//  Appitune
//
//  Created by Toan on 7/11/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit
import Stevia
class TableViewCell: UITableViewCell {
// let artistName, trackName: String
//   let previewURL: String
//   let  artworkUrl100: String
//   let  trackPrice: Double
    var  artisNamelabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    var artworkUrl100Image : UIImageView = {
        let image = UIImageView()
   
        
        return image
    }()
    var trackPrice : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sv([artisNamelabel,artworkUrl100Image,trackPrice])
       layout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func layout() {
        self.layout(
        0,
         |-0-artisNamelabel-0-| ~ 50 ,
         10,
         |-0-trackPrice-0-| ~ 50,
         10,
         |-10-artworkUrl100Image-10-| ~ 100
         
        )
    }
    
}
