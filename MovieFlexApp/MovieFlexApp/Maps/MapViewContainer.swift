//
//  MapViewContainer.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 12/27/20.
//

import SwiftUI
import MapKit

struct MapViewContainer:UIViewRepresentable {
    typealias UIViewType = MKMapView
    let mapView = MKMapView()
    var annotaions:[MKPointAnnotation]
    var selectedMapItem:MKMapItem?
    var currentLocation = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(mapView: mapView)
    }
    // coordinator works
    
    class Coordinator:NSObject,MKMapViewDelegate{
        init(mapView:MKMapView) {
            super.init()
            mapView.delegate = self
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is MKPointAnnotation) {return nil}
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
                pinAnnotationView.canShowCallout = true
                return pinAnnotationView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            // listen for the reegioin update to bind it to view model class
            NotificationCenter.default.post(name: MapViewContainer.Coordinator.regionChangedNotification,object: mapView.region)
        }
        static let regionChangedNotification = Notification.Name("regionChangedNotification")
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap()
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        return mapView
    }
    
    fileprivate func setupRegionForMap()
{
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: currentLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: currentLocation, span: span)
        uiView.setRegion(region, animated: true)
      
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotaions)
        uiView.showAnnotations(uiView.annotations, animated: false)
        uiView.annotations.forEach { annotaion in
            if annotaion.title == selectedMapItem?.name{
                uiView.selectAnnotation(annotaion, animated: true)
            }
        }
    }
}
