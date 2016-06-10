//
//  ViewController.swift
//  IntrepidCheck
//
//  Created by Colin Tan on 6/9/16.
//  Copyright © 2016 Intrepid Pursuits LLC. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    @IBOutlet weak var isCheckingSwitch: UISwitch!
    
    let locationManager = CLLocationManager()
    let notification = UILocalNotification()
    
    var isTracking = false
    
    // location of Intrepid Pursuits Third Street Office
    let fenceCenterLatitude = 42.367063
    let fenceCenterLongitude = -71.080176
    
    let fenceRadius = 50.0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isCheckingSwitch.addTarget(self, action: #selector(ViewController.isCheckingSwitchIsFlipped), forControlEvents: UIControlEvents.ValueChanged)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let geofence = defineGeofence()
        locationManager.startMonitoringForRegion(geofence)
        
        let actionCategory = UIMutableUserNotificationCategory()
        actionCategory.identifier = "actionCategory"
        actionCategory.setActions([NotificationActions.sendMessageOnSlackAction], forContext: .Minimal)
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: [actionCategory])
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        notification.alertBody = "Hello"
        notification.region = geofence
        notification.alertAction = "Send"
        notification.category = "actionCategory"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handleSendMessageNotification), name: "sendMessageNotification", object: nil)
    }
    
    func handleSendMessageNotification() {
        print("Posting on slack...")
    }
    
    // MARK: - UISwitch
    func isCheckingSwitchIsFlipped() {
        isTracking = isCheckingSwitch.on
        
        guard let notificationSetting = UIApplication.sharedApplication().currentUserNotificationSettings() else {
            return
        }
        
        if notificationSetting.types == .None {
            let alert = UIAlertController(title: "No location permission", message: "The app has not been granted permission to access your location.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited region")
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("Successfully started managing for region")
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring for region")
    }
    
    private func defineGeofence() -> CLRegion {
        let center = CLLocationCoordinate2DMake(fenceCenterLatitude, fenceCenterLongitude)
        return CLCircularRegion(center: center, radius: fenceRadius, identifier: "fence")
    }

}