//
//  ZLMoviePlayerViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import AVKit

class ZLMoviePlayerViewController: AVPlayerViewController {
    deinit {
        self.player?.removeObserver(self, forKeyPath: "status")
    }
    
    init(_ contentUrl: URL) {
        super.init(nibName: nil, bundle: nil)
        self.player = AVPlayer(url: contentUrl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsPlaybackControls = true
        self.player?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let status : AVPlayerStatus = AVPlayerStatus(rawValue: change![NSKeyValueChangeKey.newKey] as! NSNumber.IntegerLiteralType)!
            switch status{
            case .failed:
                print("failed")
            case .readyToPlay:
                self.player?.play()
            case .unknown:
                print("unknown")
            }
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.all
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
}
