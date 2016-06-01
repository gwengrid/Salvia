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
public class Task: NSManagedObject {

}

extension Task {
    func wasCompletedToday () -> Bool {
        if let today = NSDate.today() {
            if let value = self.completed?.isEqualToDate(today){
                return value
            }
        }
        return false
    }
}