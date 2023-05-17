//
//  LocationManager.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-03.
//this is the model that pulls the users location.

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    //apple specifies you must initiate and delegate the CLLocationManager as soon as possible.
    override init() {
        super.init()
        manager.delegate = self
    }
    
    var completion: (((lon: Double, lat: Double)) -> Void)?
    
    func getLocation(completion: (((lon: Double, lat: Double)) -> Void)?) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
    }
    
    //if the location has been updated, stop updating it.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        manager.stopUpdatingLocation()
        completion?((lon: location.coordinate.longitude, lat: location.coordinate.latitude))
    }
    
    //this function converts the coordinates into the name of a city.
    func resolveName(for location: CLLocation, completion: @escaping (String?) -> Void) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first, error == nil else {
                return
            }
            
            var name = ""
            
            if let city = place.locality {
                name = city
            }
            
            if let region = place.administrativeArea {
                name += ", \(region)"
            }
            completion(name)
        }
    }
}
