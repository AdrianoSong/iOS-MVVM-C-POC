//
//  LocationManager.swift
//  CoronaMap
//
//  Created by Song on 06/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    private let locationManager = CLLocationManager()

    // - API
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .notDetermined:
            print("notDetermined")// location permission not asked for yet
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")// location authorized
        case .authorizedAlways:
            print("authorizedAlways")// location authorized
        case .restricted:
            print("restricted")// location restricted
        case .denied:
            print("denied")// location denied
        default:
            print("default case")
        }
    }
}

// MARK: - Get Placemark
extension LocationManager {

    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in

            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }

            completion(placemark)
        }
    }
}
