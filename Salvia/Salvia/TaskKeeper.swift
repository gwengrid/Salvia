//
//  TaskKeeper.swift
//  Salvia
//
//  Created by gwendolyn weston on 2/10/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import SugarRecord

let NewIntentionNotification = "com.gwendolyn.newintentset"
let IntentFulfilledNotification = "com.gwendolyn.intentcompete"

class TaskKeeper {
    var db: CoreDataDefaultStorage
    
    init(db: CoreDataDefaultStorage) {
        self.db = db
    }
    
    func saveNewTask(description: String) {
        try! self.db.operation { (context, save) -> Void in
            let newTask: Task = try! context.create()
            newTask.task = description
            newTask.dateCreated = NSDate.today()
            save()
            NSNotificationCenter.defaultCenter().postNotificationName(NewIntentionNotification, object: nil)
        }
    }

    func fetchTask(forDate: NSDate) -> Task? {
        let anyComplete: NSPredicate = NSPredicate(format: "completed == %@", forDate)
        let result = try! db.fetch(Request<Task>().filteredWith(predicate: anyComplete)).first
        if let completedTask = result {
            return completedTask
        }

        return fetchNextAvailable()
    }

    func fetchNextAvailable() -> Task? {
        let anyAvailable: NSPredicate = NSPredicate(format: "completed == nil")
        return try! db.fetch(Request<Task>().filteredWith(predicate: anyAvailable).sortedWith("dateCreated", ascending: false)).first
    }

    func fetchNextInQueue() -> Task? {

        let anyComplete: NSPredicate = NSPredicate(format: "completed == %@", NSDate.today())
        let result = try! db.fetch(Request<Task>().filteredWith(predicate: anyComplete)).first
        if let completedTask = result {
            return completedTask
        }

        let anyAvailable: NSPredicate = NSPredicate(format: "completed == nil")
        return try! db.fetch(Request<Task>().filteredWith(predicate: anyAvailable).sortedWith("dateCreated", ascending: false)).first
    }


    func complete(task: Task) {

        try! self.db.operation { (context, save) -> Void in
            let predicate: NSPredicate = NSPredicate(format: "(SELF = %@)", task)
            let fetched: Task? = try! context.fetch(Request<Task>().filteredWith(predicate: predicate)).first

            fetched?.completed = NSDate.today()
            save()
            NSNotificationCenter.defaultCenter().postNotificationName(IntentFulfilledNotification, object: nil)
        }
    }
}