//
//  CustomCell.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 24/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit
import AVKit
class CustomCell: JKTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
class VideoCell: CustomCell {
    fileprivate var avPlayer: AVPlayer?
    fileprivate var avPlayerViewConroller: AVPlayerViewController?
    fileprivate var avPlayerLayer: AVPlayerLayer?
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
        self.setupPlayer()
    }
    
    func setupPlayer(){
        // Create a new AVPlayer and AVPlayerLayer
        self.avPlayer = AVPlayer()
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer?.videoGravity = .resizeAspect
        // We want video controls so we need an AVPlayerViewController
        avPlayerViewConroller = AVPlayerViewController()
        avPlayerViewConroller?.player = avPlayer
        // Insert the player into the cell view hierarchy and setup autolayout
        avPlayerViewConroller!.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.insertSubview(avPlayerViewConroller!.view, at: 0)
        avPlayerViewConroller!.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        avPlayerViewConroller!.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        avPlayerViewConroller!.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        avPlayerViewConroller!.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
  
    private func initNewPlayerItem() {
        
        // Pause the existing video (if there is one)
        
        self.isPlay = false
        
        // First we need to make sure we have a valid URL
        guard let videoPlayerItemUrl = videoItemUrl else {
            return
        }
        
        // Create a new AVAsset from the URL
        let videoAsset = AVAsset(url: videoPlayerItemUrl)
        
        videoAsset.loadValuesAsynchronously(forKeys: ["duration"]) {
            guard videoAsset.statusOfValue(forKey: "duration", error: nil) == .loaded else {
                return
            }
            
            let videoPlayerItem = AVPlayerItem(asset: videoAsset)
            DispatchQueue.main.async {
                self.avPlayer?.replaceCurrentItem(with: videoPlayerItem)
                
            }
        }
    }
    var isPlay:Bool = false{
        didSet{
            if isPlay {
                self.avPlayer?.play()
            }else{
                avPlayer?.pause()
            }
        }
    }
    
    
    var videoItemUrl: URL? {
        didSet {
            initNewPlayerItem()
        }
    }
}
