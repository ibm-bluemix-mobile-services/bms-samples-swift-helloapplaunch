//
//  AppDelegate.swift
//  Engage-Pizza
//
//  Created by Chethan Kumar on 3/16/17.
//  Copyright © 2017 Chethan Kumar. All rights reserved.
//

import UIKit
import IBMAppLaunch


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let config =   AppLaunchConfig.Builder().cacheExpiration(30).eventFlushInterval(60).fetchPolicy(.REFRESH_ON_EXPIRY).build()
        let user = AppLaunchUser.Builder(userId: "vittal").custom(key: "mail", value: "vittalpai@ymail.com").build()
 
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH_STAGING, appId: "852301c1-128e-4b11-80f5-9d113cdb976f", clientSecret: "ecf53cdf-40ca-4239-9c49-15cdd88a36e7", config: config, user: user) { (Success, Failure) in
            if(Success != nil ){
                print("Initialization Successful")
            } else {
                print("Initialization Failed")
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

