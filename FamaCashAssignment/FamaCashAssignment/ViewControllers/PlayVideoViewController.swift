//
//  PlayVideoViewController.swift
//  FamaCashAssignment
//
//  Created by Mac on 26/07/20.
//  Copyright © 2020 Jeet. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController {
    
    @IBOutlet weak var vwVideoPlay: YTPlayerView!
    
    var videoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    private func initialSetup() {
        if let safeVideoId = videoId {
            self.startLoading()
            vwVideoPlay.delegate = self
            vwVideoPlay.load(withVideoId: safeVideoId)
        } else {
            self.showAlert(title: kError, message: kNoDataFound)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PlayVideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.stopLoading()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        self.showAlert(title: kError, message: kNoDataFound)
        self.stopLoading()
    }
}
