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
    
    func context (){
        
    }

    func saveNewTask(description: String) {
        self.db.operation { (context, save) -> Void in
            let newTask: Task = try! context.create()
            newTask.task = description
            save()
        }
    }

    func fetchNextInQueue() -> Task? {
        let task = try! db.fetch(Request<Task>().sortedWith("dateCreated", ascending: false)).first
        return task
    }

    func complete(task: Task) {
        self.db.operation { (context, save) -> Void in
            task.completed = true
            save()
        }

    }

}