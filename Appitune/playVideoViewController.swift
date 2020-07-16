//
//  playVideoViewController.swift
//  Appitune
//
//  Created by Toan on 7/11/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit
import Stevia
import AVFoundation
class playVideoViewController: UIViewController {
    
    
    let  VideoView : VideoPlaerView = {
        let view = VideoPlaerView()
        return view
    }()
    var url = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sv(VideoView)
        layout()
        VideoView.urlString = url
    }
    func layout(){
        view.layout(
        0,
        |-0-VideoView.width(UIScreen.main.bounds.width)-0-| , 0
        )
    }

}
class VideoPlaerView : UIView {
    
    var urlString = String()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
       if let url = NSURL(string: urlString) {
        let player = AVPlayer(url: url as URL)
        let PlayerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(PlayerLayer)
        PlayerLayer.frame = self.frame
        player.play()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
