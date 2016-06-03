//
//  AppDelegate.swift
//  Salvia
//
//  Created by gwendolyn weston on 1/20/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import SugarRecord
import Amplitude_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let db = TaskKeeper(db: coreDataStorage())

        let headSpace = HeadViewController(keeper:db)

        self.window?.rootViewController = headSpace
        self.window?.makeKeyAndVisible()

        Amplitude.instance().initializeApiKey("a79617100fa1dfc49eaf2ce67bf1362c")
        Amplitude.instance().logEvent("PurplePresenceAppOpened")

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

