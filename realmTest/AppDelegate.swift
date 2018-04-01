//
//  AppDelegate.swift
//  realmTest
//
//  Created by Skander Jabouzi on 2017-12-30.
//  Copyright © 2017 Skander Jabouzi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let config = Realm.Configuration(
            
            schemaVersion: 3,
            
            migrationBlock: { migration, oldSchemaVersion in
                debugPrint("oldSchemaVersion \(oldSchemaVersion)")
                if (oldSchemaVersion < 3) {
                    migration.deleteData(forType: Task.className())
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController(style: .plain))
        window?.makeKeyAndVisible()
        
        return true
    }
}
