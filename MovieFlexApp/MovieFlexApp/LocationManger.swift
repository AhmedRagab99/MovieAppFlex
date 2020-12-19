//
//  LocationManger.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 12/19/20.
//

import Foundation
import CoreLocation


final class LocationManger:NSObject,ObservableObject{
    
    
   private  var locationManger = CLLocationManager()
    private var previousLocation :CLLocation?
    private lazy var geocoder = CLGeocoder()
    var regionName = ""
    
    @Published var currentLocation = CLLocation()
    @Published var distanceFromCurrentLocation = CLLocationDistance()

    @Published var currentAdress = ""
    @Published var inRegion = false
    @Published var locationAlertError = ""
    
    
    override init() {
        super.init()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.allowsBackgroundLocationUpdates = true
    }
    
    func startLocationServecises(){
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            print("restrected")
            locationAlertError =  "restrected"
        case .denied:
            print("denied")
            locationAlertError =  "restrected"
        case .authorizedAlways:
            locationManger.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManger.startUpdatingLocation()
        @unknown default:
            print("unknown case")
        }
    }
    
    func fetchAddress (for location:CLLocation){
        currentAdress = ""
        geocoder.reverseGeocodeLocation(location) {[weak self] (placemarks, error) in
            guard let self = self else {return}
            if let error = error {
                print("canont reverse or get the address with \(error.localizedDescription)")
                self.locationAlertError = "canont reverse or get the address with \(error.localizedDescription)"
            }
            guard let placemark = placemarks?.first else {return }
            if let streetNumber = placemark.subThoroughfare,let street  = placemark.thoroughfare,let city = placemark.locality,let state = placemark.administrativeArea{
                DispatchQueue.main.async {
                    self.currentAdress = "\(streetNumber), \(street), \(city), \(state)"
                }
            } else if let city = placemark.locality,let state = placemark.administrativeArea {
                
                DispatchQueue.main.async {
                    self.currentAdress = "\(city), \(state)"
                }
            }else{
                self.currentAdress = "address unkonw"
            }
        }
    }
    
    
    func setupMonitoring(for places:[CLLocation]){
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
            for place in places{
                let region = CLCircularRegion(center: place.coordinate, radius: 500, identifier: UUID().description)
                region.notifyOnEntry = true
                locationManger.startMonitoring(for: region)
            }
        }
    }
}


extension LocationManger:CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManger.authorizationStatus == .authorizedWhenInUse || locationManger.authorizationStatus == .authorizedAlways{
            locationManger.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest  = locations.first else {return}
        if previousLocation == nil{
            previousLocation = latest
        }else {
            let distanceInMeters = previousLocation?.distance(from: latest) ?? 0
            previousLocation = latest
            currentLocation = latest
            distanceFromCurrentLocation = distanceInMeters
            fetchAddress(for: latest)
        }
        print(latest)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        inRegion = true
        regionName = region.identifier
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError  = error as? CLError else {return}
        
        switch clError{
        case CLError.denied:
            print("access denied")
        case CLError.deferredNotUpdatingLocation:
            print("can not update the location")
        default:
            print("another location error")
        }
    }
}
