//
//  LocationProvider.swift
//  TempoDemo
//
//  Created by Nuno Alves de Sousa on 25/10/2020.
//

import SwiftUI
import CoreLocation

/// An observable object that publishes location and heading data
public class LocationProvider: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published public private(set) var lastKnownLocation: CLLocationCoordinate2D?
    @Published public private(set) var angle: Angle? = nil
    private let locationManager: CLLocationManager
    
    public override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
    }
    
    /// Requests the one-time delivery of the user’s current location.
    public func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    /// Starts the generation of updates that report the user’s current location.
    public func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /// Stops the generation of location updates.
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    /// Starts the generation of updates that report the user’s current heading.
    public func startUpdatingHeading() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingHeading()
        }
    }
    
    /// Stops the generation of heading updates.
    public func stopUpdatingHeading() {
        self.locationManager.stopUpdatingHeading()
        self.angle = nil
    }
}

extension LocationProvider {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.lastKnownLocation = locations.first?.coordinate
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.angle = .degrees(-1 * newHeading.magneticHeading)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationProvider failed to find user's location: \(error.localizedDescription)")
    }
}
