//
//  ExpandedImageViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit

var expandedImageViewController: ExpandedImageViewController!

class ExpandedImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var congestionLocation: CongestionLocation!
    var currentIndex = 0
    var playing = false
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandedImageViewController = self
        //imageView.sd_setImageWithURL(NSURL(string: congestionLocation.imageUrl!), placeholderImage: nil, options: SDWebImageOptions.RefreshCached)
        loadImage()
        navigationItem.title = congestionLocation.title
        
        let transform = CGAffineTransformMakeScale(1.0, 3.0)
        progressView.transform = transform
        progressView.setProgress(0.0, animated: false)
        
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.layer.removeAllAnimations()
//    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCongestionLocation(congestionLocation: CongestionLocation) {
        self.congestionLocation = congestionLocation
    }
    
    @IBAction func closeTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadImage() {
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> () in
                if cacheType == .None {
                    println("Downloaed from the web")
                    expandedImageViewController.congestionLocation.storedImages.append(expandedImageViewController.imageView.image!)
                    expandedImageViewController.currentIndex = expandedImageViewController.congestionLocation.storedImages.count - 1
                }
            }
        let url = NSURL(string: congestionLocation.imageUrl!)
        imageView.sd_setImageWithURL(url, placeholderImage: nil, options: .RefreshCached, completed: block)
    }

    @IBAction func refresh(sender: UIBarButtonItem) {
        loadImage()
    }

    @IBAction func forwardTapped(sender: UIBarButtonItem) {
        if congestionLocation.storedImages.count > 1 {
            playing = !playing
            if playing {
                sender.image = UIImage(named: "Stop")
                timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("play"), userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                sender.image = UIImage(named: "Play")
            }
        }
    }
    
    func play() {
        self.currentIndex = ++self.currentIndex % self.congestionLocation.storedImages.count
        self.imageView.image = self.congestionLocation.storedImages[self.currentIndex]
        progressView.setProgress(Float(self.currentIndex) / Float(self.congestionLocation.storedImages.count - 1), animated: false)
        println("Animating")
    }
    
//    @IBAction func backTapped(sender: UIBarButtonItem) {
//        if congestionLocation.storedImages.count > 0 {
//            --currentIndex
//            if currentIndex < 0 {
//                currentIndex = congestionLocation.storedImages.count - 1
//            }
//            imageView.image = congestionLocation.storedImages[currentIndex]
//        }
//    }
    
    
    
}
