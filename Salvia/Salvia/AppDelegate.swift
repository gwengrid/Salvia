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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Today") as? TodayViewController
        if let todayVC = vc {
            todayVC.taskKeeper = TaskKeeper(db: coreDataStorage())
            let nav = UINavigationController(rootViewController: todayVC)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
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

