//
//  AppDelegate.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

let themeColor = UIColor(red: 0.99, green: 0.90, blue: 0.80, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // How to detect if first time launching
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        println("application did finish launching")
        window?.tintColor = themeColor
        // Override point for customization after application launch.
        if let firstLaunch =  NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch") {
            println("Not the first launch")
        } else {
            println("First launch, setting NSUserDefault.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let welcomeController = storyBoard.instantiateViewControllerWithIdentifier("Welcome Controller") as! WelcomeViewController
            self.window?.rootViewController?.presentViewController(welcomeController, animated: true, completion: nil)
        }
        return true
    }
    
    // let urlAccess = authorizeUserUsingClientId("GBFQRRGTBCGRIYX5H204VMOD1XRQRYDVZW1UCFNFYQVLKZLY", callbackURLString: "cravefoodfinder://foursquare", allowShowingAppStore: true)
    
    //  let errorCode = accessCodeForFSOAuthURL(urlAccess, error:
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return true
    }
    
    //   class func authorizeUserUsingClientId(clientID: String, callbackURLString: String, allowShowingAppStore: Bool) -> FSOAuthStatusCode {}
    
    //  class func accessCodeForFSOAuthURL(url: NSURL, error errorCode: FSOAuthErrorCode) -> String {}
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

