//
//  AppDelegate.swift
//  Engage-Pizza
//
//  Created by Chethan Kumar on 3/16/17.
//  Copyright © 2017 Chethan Kumar. All rights reserved.
//

import UIKit
import AppLaunch


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
 
        AppLaunch.sharedInstance.initializeWithAppGUID(applicationId: "cb4baa34-e75e-4567-9fd2-0fdf37573c0f", clientSecret: "6d8267ee-9e1e-47ec-b622-33d36704d1e8", region: US_SOUTH)
        
        AppLaunch.sharedInstance.registerWith(userId: "chethan") { (registrationResponse, registrationStatus, registrationError) in
            if(registrationStatus == 201){
                print("User is registered : \(registrationResponse)")
                
                AppLaunch.sharedInstance.actions(completionHandler: { (features, actionsStatus, actionsError) in
                    if(actionsStatus == 200){
                        print("Got Client Actions")
                    }
                })
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }
   

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

