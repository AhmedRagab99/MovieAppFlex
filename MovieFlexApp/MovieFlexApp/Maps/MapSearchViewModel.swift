//
//  MapSearchViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 12/27/20.
//

import Combine
import CoreLocation
import MapKit


class MapSearchViewModel:NSObject,ObservableObject{
    @Published var annotaions = [MKPointAnnotation]()
    @Published var isSearching  = false
    @Published var searchingQuearyText = ""
    @Published var mapItems  = [MKMapItem]()
    @Published var selectedMapItem = MKMapItem()
    @Published var currentLocation = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
    fileprivate var region : MKCoordinateRegion?
    private var disposeBag = Set<AnyCancellable>()
    
    
    let locationManger = CLLocationManager()
    override init() {
        super.init()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
//        debounceSearchQuearyText()
        NotificationCenter.default.addObserver(forName: MapViewContainer.Coordinator.regionChangedNotification, object: nil, queue: .main) { [weak self](notification) in
            self?.region = notification.object as? MKCoordinateRegion
        }
    }
    private func debounceSearchQuearyText(){
        $searchingQuearyText.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink {[weak self] (value) in
                guard let self = self else {return}
                self.performLocalSearch(queary:value)
            }
            .store(in: &disposeBag)
    }
    
    
    func performLocalSearch(queary:String = "AirPorts"){
        self.isSearching = true
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = queary
        if let region = self.region{
            request.region = region
        }
        let localSearch  = MKLocalSearch(request: request)
        localSearch.start { (resp, error) in
            
            var airportsAnnotaions = [MKPointAnnotation]()
            self.mapItems  = resp?.mapItems ?? []
            resp?.mapItems.forEach({mapItem in
                
                print(mapItem.name ?? "")
                let annotaion = MKPointAnnotation()
                annotaion.title = mapItem.name
                annotaion.coordinate = mapItem.placemark.coordinate
                airportsAnnotaions.append(annotaion)
            })
            self.isSearching = false
            self.annotaions = airportsAnnotaions
        }
    }
    
}


extension MapSearchViewModel:CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManger.authorizationStatus == .authorizedWhenInUse || locationManger.authorizationStatus == .authorizedAlways{
            locationManger.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation  = locations.first else {return}
        self.currentLocation = firstLocation.coordinate
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

