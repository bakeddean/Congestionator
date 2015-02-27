//
//  UIColorExtension.swift
//  EngagementHub
//
//  Created by Dean Woodward on 9/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class func rGBAHelper(red: CGFloat,_ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor! {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    class func themeDarkGreyColor() -> UIColor {
        return rGBAHelper(83.0, 82.0, 77.0, 1.0)
    }
    
    class func themeGreenColor() -> UIColor {
        return rGBAHelper(26.0, 188.0, 156.0, 1.0)
    }
    
    class func themeBlueColor() -> UIColor {
        return rGBAHelper(52.0, 152.0, 219.0, 1.0)
    }
    
}
