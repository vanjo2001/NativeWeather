//
//  LocationService.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import CoreLocation


protocol CoreLocationServiceProtocol: class {
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> ())
    var updateLocation: ((CLLocation) -> ())? { get set }
}


class CoreLocationService: NSObject, CoreLocationServiceProtocol {
    
    var updateLocation: ((CLLocation) -> ())?
    
    private let locationManager = CLLocationManager()
    
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "error")
                completion(nil)
                return
            }
            
            guard let placemark = placemark?[0] else {
                print("error placemark")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}


extension CoreLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lastLocation = locations.last!
        updateLocation?(lastLocation)
        
    }
}
