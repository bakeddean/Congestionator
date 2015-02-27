//
//  UIAppearanceConfigurator.swift
//  EngagementHub
//
//  Created by Dean Woodward on 9/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation
import UIKit

class UIAppearanceConfigurator {

    class func configureUIApprearance() {        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(17), NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().barTintColor = UIColor.themeDarkGreyColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
            
}