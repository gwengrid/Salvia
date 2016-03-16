//
//  Task.swift
//  
//
//  Created by gwendolyn weston on 2/11/16.
//
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func wasCompletedToday () -> Bool? {
        if let today = NSDate.today() {
            return self.completed?.isEqualToDate(today)
        }
        return false
    }
}
