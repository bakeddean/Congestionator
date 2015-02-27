//
//  NetworkIndicator.swift
//  EngagementHub
//
//  Created by Malcolm Pullman on 17/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

class NetworkIndicator : NSObject {
    
    class func showIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    class func hideIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    class func addActivityIndicatorToView(view: UIView) {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        indicator.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2)
        indicator.color = UIColor.blackColor()
        indicator.alpha = 0.5
        indicator.tag = 1
        indicator.startAnimating()
        view.addSubview(indicator)
    }
    
    class func removeActivityIndicatorFromView(view: UIView) {
        let activityIndicator = view.viewWithTag(1)
        if let indicator = activityIndicator {
            indicator.removeFromSuperview()
        }
    }
}