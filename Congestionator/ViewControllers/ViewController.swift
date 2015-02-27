//
//  ViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadCongestionLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Post data
    
    func loadCongestionLocations() {
        ContentService.sharedInstance.getCongestionLocations(
            success: {(congestionLocations) -> () in
                //self.refreshControl.endRefreshing()
                
//                self.posts = posts + self.posts
//                var indexPaths = [NSIndexPath]()
//                for index in 0..<posts.count {
//                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                    indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
//                }
//                self.collectionView?.insertItemsAtIndexPaths(indexPaths)
            },
            failure: {(errorResponse, operation) -> () in
                //self.refreshControl.endRefreshing()
            }
        )
    }



}

