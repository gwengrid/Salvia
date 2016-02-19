//
//  Task+CoreDataProperties.swift
//  
//
//  Created by gwendolyn weston on 2/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var completed: NSDate?
    @NSManaged var dateCreated: NSDate?
    @NSManaged var task: String?

    func wasCompletedToday () {

    }

}
