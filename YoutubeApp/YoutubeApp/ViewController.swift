//
//  ViewController.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/1/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit
import YouTubePlayer
import  youtube_ios_player_helper

class ViewController: UIViewController {
    
    
    // MARK properties
//    @IBOutlet var youtube: YouTubePlayerView
    var idVideo: String!
    @IBOutlet var youtubeView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        setupNavigation()
//        youtube.loadVideoID(idVideo)
        youtubeView.load(withVideoId: idVideo)
        
    }

    @objc func back() {
        print("abcd")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func setupNavigation(){
        
    }
   

}

