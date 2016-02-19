//
//  NSDate+Helper.swift
//  Salvia
//
//  Created by gwendolyn weston on 2/12/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation

extension NSDate {
    class func today() -> NSDate? {
        let cal = NSCalendar.currentCalendar()
        let componenets = cal.components([.Era, .Year, .Month, .Day], fromDate: NSDate())
        if let today = cal.dateFromComponents(componenets) {
            return today
        }
        return nil
    }
}