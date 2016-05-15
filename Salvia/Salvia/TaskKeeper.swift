//
//  TaskKeeper.swift
//  Salvia
//
//  Created by gwendolyn weston on 2/10/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import SugarRecord

class TaskKeeper {
    var db: CoreDataDefaultStorage
    
    init(db: CoreDataDefaultStorage) {
        self.db = db
    }
    
    func saveNewTask(description: String) {
        try! self.db.operation { (context, save) -> Void in
            let newTask: Task = try! context.create()
            newTask.task = description
            if let date = NSDate.today() {
                newTask.dateCreated = date
            }
            save()
        }
    }

    func fetchNextInQueue() -> Task? {
        let task = try! db.fetch(Request<Task>().sortedWith("dateCreated", ascending: false)).first
        if task?.completed != nil && task?.wasCompletedToday() != true {
            return nil
        }
        return task
    }

    func complete(task: Task) {

        try! self.db.operation { (context, save) -> Void in
            let predicate: NSPredicate = NSPredicate(format: "(SELF = %@)", task)
            let fetched: Task? = try! context.fetch(Request<Task>().filteredWith(predicate: predicate)).first

            if let today = NSDate.today() {
                if let saved = fetched {
                    saved.completed = today
                    save()
                }
            }

        }
    }
}