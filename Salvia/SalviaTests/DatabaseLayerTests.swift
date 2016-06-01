//
//  DatabaseLayerTests.swift
//  Presence
//
//  Created by gwendolyn weston on 5/30/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import XCTest
@testable import SugarRecord
@testable import Presence

class DatabaseLayerTests: XCTestCase {

    var db: CoreDataDefaultStorage!
    var dbLayer: TaskKeeper!

    
    override func setUp() {
        super.setUp()
        let store = CoreData.Store.Named("test")
        let bundle = NSBundle.mainBundle()
        let model = CoreData.ObjectModel.Merged([bundle])
        db = try! CoreDataDefaultStorage(store: store, model: model)
        dbLayer = TaskKeeper(db: db)
    }
    
    override func tearDown() {
        super.tearDown()
        _ = try? db?.removeStore()
    }

    func testSavingTask() {
        let task = dbLayer.fetchNextInQueue()
        XCTAssertNil(task)

        let taskDescription = "sexypurple"
        dbLayer.saveNewTask(taskDescription)

        try! self.db.operation { (context, save) -> Void in
            let fetched = try! context.fetch(Request<Task>())
            XCTAssertTrue(fetched.count == 1)

            let onlyTask = fetched.first!
            XCTAssertTrue(onlyTask.task == taskDescription)
            XCTAssertNil(onlyTask.completed)
        }
    }

    func testCompleteTask() {
        var task = dbLayer.fetchNextInQueue()
        XCTAssertNil(task)

        let taskDescription = "sexypurple"
        dbLayer.saveNewTask(taskDescription)

        task = dbLayer.fetchNextInQueue()
        XCTAssertNotNil(task)
        dbLayer.complete(task!)

        task = dbLayer.fetchNextInQueue()
        XCTAssertTrue((task!.completed) != nil)
    }

    func testFetchTask() {
        let today = NSDate.today()
        var task = dbLayer.fetchTask(today)
        XCTAssertNil(task)

        let firstTask = "sexypurple"
        dbLayer.saveNewTask(firstTask)
        task = dbLayer.fetchTask(today)
        XCTAssertEqual(task!.task, firstTask)
        XCTAssertNil(task!.completed)

        dbLayer.complete(task!)
        task = dbLayer.fetchTask(today)
        XCTAssertEqual(task!.task, firstTask)
        XCTAssertNotNil(task!.completed)
        XCTAssertTrue(task!.completed == today)

        let dayComponent = NSDateComponents()
        dayComponent.day = 1
        let cal = NSCalendar.currentCalendar()
        let dayAfter = cal.dateByAddingComponents(dayComponent, toDate: today, options: [])!

        let anotherTask = "sexygray"
        dbLayer.saveNewTask(anotherTask)
        task = dbLayer.fetchTask(dayAfter)
        XCTAssertEqual(task!.task, anotherTask)
        XCTAssertNil(task!.completed)
    }
}
