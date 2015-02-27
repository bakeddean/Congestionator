//
//  ExpandedImageViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit

class ExpandedImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var congestionLocation: CongestionLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.sd_setImageWithURL(NSURL(string: congestionLocation.imageUrl!), placeholderImage: nil, options: SDWebImageOptions.RefreshCached)
        navigationItem.title = congestionLocation.title
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.layer.removeAllAnimations()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCongestionLocation(congestionLocation: CongestionLocation) {
        self.congestionLocation = congestionLocation
        //imageView.sd_setImageWithURL(NSURL(string: congestionLocation.imageUrl!))
    }
    
    @IBAction func closeTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func refresh(sender: UIBarButtonItem) {
        imageView.sd_setImageWithURL(NSURL(string: congestionLocation.imageUrl!), placeholderImage: nil, options: SDWebImageOptions.RefreshCached)
    }

}
