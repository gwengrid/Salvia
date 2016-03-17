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

}

extension Task {
    func wasCompletedToday () -> Bool? {
        if let today = NSDate.today() {
            return self.completed?.isEqualToDate(today)
        }
        return false
    }
}