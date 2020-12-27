//
//  MapSearchView.swift
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
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap()
        return mapView
    }
    
    fileprivate func setupRegionForMap(){
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
//        if let annotaion = annotaion{
//            uiView.addAnnotation(annotaion)
//        }
        uiView.addAnnotations(annotaions)
        uiView.showAnnotations(uiView.annotations, animated: false)
    }
}

struct MapSearchView: View {
    @State var dummyAnnotaions:MKPointAnnotation?
    @State var annotaions  = [ MKPointAnnotation]()
    var body: some View {
        ZStack(alignment:.top){
            MapViewContainer(annotaions: annotaions)
                .padding(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
            
          
            HStack{
                Button(action:{
//                    let annotaion = MKPointAnnotation()
//                    annotaion.title = "SAN FRAN"
//                    annotaion.coordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
//                    self.dummyAnnotaions = annotaion
                    
                    let request = MKLocalSearch.Request()
                    request.naturalLanguageQuery = "AirPorts"
                    let localSearch  = MKLocalSearch(request: request)
                   
                    
                    localSearch.start { (resp, error) in
                        var airportsAnnotaions = [MKPointAnnotation]()
                        resp?.mapItems.forEach({mapItem in
                            print(mapItem.name ?? "")
                            let annotaion = MKPointAnnotation()
                            annotaion.title = mapItem.name
                            annotaion.coordinate = mapItem.placemark.coordinate
                            airportsAnnotaions.append(annotaion)
                        })
                        self.annotaions = airportsAnnotaions
                    }
                }){
                    Text("Search for AirPorts")
                        .padding()
                        .background(Color.white)
                }
                .cornerRadius(10)
                Button(action:{}){
                    Text("Clear Annotations")
                        .padding()
                        .background(Color.white)
                }
                .cornerRadius(10)
              
                
            }
            .padding()
            .shadow(radius: 5)
            
            
            
        }
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
