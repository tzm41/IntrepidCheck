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
    @IBOutlet private weak var isCheckingSwitch: UISwitch!

    private let locationManager = CLLocationManager()

    // location of Intrepid Pursuits Third Street Office
    private let fenceCenterLatitude = 42.367063
    private let fenceCenterLongitude = -71.080176
    private let fenceRadius = 50.0
    private var geofence: CLRegion?
    private let locationName = "Third St"
    
    let entryNotificationIdentifier = "sendMessageOnEntryNotification"
    let exitNotificationIdentifier = "sendMessageOnExitNotification"
    let entryActionCategoryIdentifier = "entryActionCategory"
    let exitActionCategoryIdentifier = "exitActionCategory"

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        isCheckingSwitch.addTarget(self, action: #selector(ViewController.isCheckingSwitchFlipped), forControlEvents: UIControlEvents.ValueChanged)

        let center = CLLocationCoordinate2DMake(fenceCenterLatitude, fenceCenterLongitude)
        geofence = CLCircularRegion(center: center, radius: fenceRadius, identifier: "fence")

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        registerNotificationSettings()
    }

    // MARK: - UISwitch
    func isCheckingSwitchFlipped() {
        if isCheckingSwitch.on {
            enableNotification()
        } else {
            disableNotification()
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        scheduleNotificationWithBody("Entering region", category: entryActionCategoryIdentifier)
    }

    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        scheduleNotificationWithBody("Exiting region", category: exitActionCategoryIdentifier)
    }

    private func scheduleNotificationWithBody(body: String, category: String) {
        let notification = UILocalNotification()
        notification.alertAction = "Swipe to send message"
        notification.alertBody = body
        notification.category = category
        notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    // MARK: - UILocalNotification
    private func enableNotification() {
        locationManager.startMonitoringForRegion(geofence!)
    }

    private func disableNotification() {
        locationManager.stopMonitoringForRegion(geofence!)
    }

    private func registerNotificationSettings() {
        let entryActionCategory = UIMutableUserNotificationCategory()
        let exitActionCategory = UIMutableUserNotificationCategory()
        entryActionCategory.identifier = entryActionCategoryIdentifier
        exitActionCategory.identifier = exitActionCategoryIdentifier
        entryActionCategory.setActions([NotificationActions.sendMessageOnEntryAction], forContext: .Minimal)
        exitActionCategory.setActions([NotificationActions.sendMessageOnExitAction], forContext: .Minimal)

        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: [entryActionCategory, exitActionCategory])
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)

        // observers for notification actions
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handlePostEnteringMessageAction), name: entryNotificationIdentifier, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handlePostExitingMessageAction), name: exitNotificationIdentifier, object: nil)
    }

    func handlePostEnteringMessageAction() {
        SlackService.sharedService.postMessageWithBody("Checking in at \(locationName)!")
    }

    func handlePostExitingMessageAction() {
        SlackService.sharedService.postMessageWithBody("Checking out from \(locationName)!")
    }
}