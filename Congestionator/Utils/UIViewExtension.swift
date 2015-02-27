//
//  UIViewExtension.swift
//  EngagementHub
//
//  Created by Dean Woodward on 24/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

extension UIView {

    func borderWithColor(color: UIColor, width: CGFloat, radius: CGFloat) {
        layer.borderColor = color.CGColor
        layer.borderWidth = width
        
        if radius > 0.0 {
            clipsToBounds = true
            layer.cornerRadius = radius
        }
    }

}