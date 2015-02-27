//
//  UIImageExtension.swift
//  EngagementHub
//
//  Created by Dean Woodward on 9/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

  class func imageWithColor(color: UIColor) -> UIImage {
      var rect = CGRectMake(0, 0, 1, 1)
      UIGraphicsBeginImageContext(rect.size)
      var context = UIGraphicsGetCurrentContext()
      CGContextSetFillColorWithColor(context, color.CGColor)
      CGContextFillRect(context, rect)
      var image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return image
  }
  
  func tintedGradientImageWithColor(color: UIColor) -> UIImage {
    return self.tintedImageWithColor(color, blendMode:kCGBlendModeOverlay)
  }
  
  func tintedImageWithColor(color: UIColor) -> UIImage {
    return self.tintedImageWithColor(color, blendMode:kCGBlendModeDestinationIn)
  }
  
  private func tintedImageWithColor(color: UIColor, blendMode: CGBlendMode) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
    color.setFill()
    let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    UIRectFill(bounds)
    self.drawInRect(bounds, blendMode:blendMode, alpha:1.0)

    if blendMode.value != kCGBlendModeDestinationIn.value {
      self.drawInRect(bounds, blendMode:kCGBlendModeDestinationIn, alpha:1.0)
    }
    
    let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return tintedImage
  }
  
}
