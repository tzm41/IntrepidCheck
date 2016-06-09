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
    @IBOutlet weak var checkingSwitch: UISwitch!
    
    let locationManager = CLLocationManager()
    
    // location of Intrepid Pursuits Third Street Office
    let fenceCenterLatitude = 42.367063
    let fenceCenterLogitude = -71.080176
    
    let fenceRadius = 50.0

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        
        locationManager.startMonitoringForRegion(defineGeofence())
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        print("Successfully started managing for region")
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring for region")
    }
    
    private func defineGeofence() -> CLRegion {
        let center = CLLocationCoordinate2DMake(fenceCenterLatitude, fenceCenterLogitude)
        return CLCircularRegion(center: center, radius: fenceRadius, identifier: "fence")
    }

}