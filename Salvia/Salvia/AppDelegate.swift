//
//  AppDelegate.swift
//  Salvia
//
//  Created by gwendolyn weston on 1/20/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import SugarRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let db = TaskKeeper(db: coreDataStorage())
        let intentionSpace = IntentionViewController(keeper: db)
        let headSpace = HeadViewController(intent: intentionSpace)
        
        self.window?.rootViewController = headSpace
        self.window?.makeKeyAndVisible()

        return true
    }

    func coreDataStorage() -> CoreDataDefaultStorage {
        let store = CoreData.Store.Named("db")
        let bundle = NSBundle.mainBundle()
        let model = CoreData.ObjectModel.Merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        return defaultStorage
    }
}

