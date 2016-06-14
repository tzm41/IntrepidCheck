//
//  AppDelegate.swift
//  IntrepidCheck
//
//  Created by Colin Tan on 6/9/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let vc = self.window?.rootViewController as! ViewController? {
            if notification.category == vc.entryActionCategoryIdentifier {
                presentAlertWithTitle("Entering", message: "You are entering the region", notificationName: vc.entryNotificationIdentifier, viewController: vc)
            } else if notification.category == vc.exitActionCategoryIdentifier {
                presentAlertWithTitle("Exiting", message: "You are exiting the region", notificationName: vc.exitNotificationIdentifier, viewController: vc)
            }
        }
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        if let vc = self.window?.rootViewController as! ViewController? {
            if identifier == NotificationActions.entryActionIdentifier {
                NSNotificationCenter.defaultCenter().postNotificationName(vc.entryNotificationIdentifier, object: nil)
            } else if identifier == NotificationActions.exitActionIdentifier {
                NSNotificationCenter.defaultCenter().postNotificationName(vc.exitNotificationIdentifier, object: nil)
            }
        }
        completionHandler()
    }

    private func presentAlertWithTitle(title: String, message: String, notificationName: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        let postAction = UIAlertAction(title: "Post", style: .Default) { action in
            NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: nil)
        }
        alert.addAction(okAction)
        alert.addAction(postAction)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

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

