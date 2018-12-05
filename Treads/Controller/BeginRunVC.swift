//
//  BeginRunVC.swift
//  Treads
//
//  Created by gdm on 12/3/18.
//  Copyright © 2018 gdm. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet weak var lastRunClosedButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBackgroundView: UIView!
    @IBOutlet weak var lastRunStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            lastRunStackView.isHidden = true
            lastRunBackgroundView.isHidden = true
            lastRunClosedButton.isHidden = true
            return
        }
        lastRunStackView.isHidden = false
        lastRunBackgroundView.isHidden = false
        lastRunClosedButton.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
    }
    
    @IBAction func lastRunClosedPressed(_ sender: Any) {
        lastRunStackView.isHidden = true
        lastRunBackgroundView.isHidden = true
        lastRunClosedButton.isHidden = true
    }
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}

