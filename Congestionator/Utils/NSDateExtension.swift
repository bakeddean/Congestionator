//
//  NSDateExtension.swift
//  EngagementHub
//
//  Created by Calvin Lai on 2/09/14.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import Foundation

extension NSDate {
    func nzDateLongStyleString() -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .NoStyle
        formatter.dateStyle = .LongStyle
        let nzLocale = NSLocale(localeIdentifier: "en_NZ")
        formatter.locale = nzLocale
        formatter.timeZone = NSTimeZone.systemTimeZone()
        return formatter.stringFromDate(self)
    }
}
