//
//  NSDate+Helper.swift
//  Salvia
//
//  Created by gwendolyn weston on 2/12/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation

extension NSDate {
    struct Date {
        static let formatterShortDate = NSDateFormatter(dateFormat: "dd-MM-yyyy")
    }
    var shortDate: String {
        return Date.formatterShortDate.stringFromDate(self)
    }

    class func today() -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let componenets = cal.components([.Year, .Month, .Day], fromDate:NSDate())
        return cal.dateFromComponents(componenets)!
    }
}

extension NSDateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
