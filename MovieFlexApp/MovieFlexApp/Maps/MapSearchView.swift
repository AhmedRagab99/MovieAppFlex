//
//  MapSearchView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 12/27/20.
//

import SwiftUI
import MapKit
import Combine


struct SelectDestinationLocationView:View{
    @Binding var isShowing:Bool
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @State var searchQuery = ""
   
    @ObservedObject var viewModel:MapSearchViewModel
    var body:some View{
        
        VStack(spacing:12){
            HStack(spacing:8) {
                Button(action:{self.isShowing = false}){
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                 
                }
                TextField("Destenation location ",text:$searchQuery)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).debounce(for: .milliseconds(500), scheduler: RunLoop.main), perform: { _ in
                        viewModel.performLocalSearch(queary: self.searchQuery)

                    })
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                    .background(Color(UIColor.systemGray2))
                    .shadow(radius: 5)
                    .cornerRadius(5)
            }
            
            if viewModel.mapItems.count > 0{
                ScrollView{
                    ForEach(viewModel.mapItems,id:\.self){item in
                        
                        Button(action:{
                            self.directionEnv.destinationMapItem = item
                            self.isShowing = false
                        }){
                        HStack{
                            VStack(alignment:.leading){
                                Text("\(item.name ?? "")")
                                    .font(.headline)
                                Text("\(item.address())")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                        .foregroundColor(Color.primary)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


struct SelectSourceLocationView:View{
    @Binding var isShowing:Bool
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @State var searchQuery = ""
   
    @ObservedObject var viewModel:MapSearchViewModel
    var body:some View{
        
        VStack(spacing:12){
            HStack(spacing:8) {
                Button(action:{self.isShowing = false}){
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                 
                }
                TextField("Destenation location ",text:$searchQuery)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).debounce(for: .milliseconds(500), scheduler: RunLoop.main), perform: { _ in
                        viewModel.performLocalSearch(queary: self.searchQuery)

                    })
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                    .background(Color(UIColor.systemGray2))
                    .shadow(radius: 5)
                    .cornerRadius(5)
            }
            
            if viewModel.mapItems.count > 0{
                ScrollView{
                    ForEach(viewModel.mapItems,id:\.self){item in
                        
                        Button(action:{
                            self.directionEnv.sourceMapItem = item
                            self.isShowing = false
                        }){
                        HStack{
                            VStack(alignment:.leading){
                                Text("\(item.name ?? "")")
                                    .font(.headline)
                                Text("\(item.address())")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                        .foregroundColor(Color.primary)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct MapSearchView: View {
    @StateObject var mapSearchViewModel = MapSearchViewModel()
    @State var isSourceSelected = false
    @State var isDestinationSelected = false
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @State var ShowModel = false

    var body: some View {
        NavigationView {
            ZStack(alignment:.top){
                GeometryReader { reader in
                    
                    MapViewContainer(annotaions: mapSearchViewModel.annotaions,selectedMapItem: mapSearchViewModel.selectedMapItem,currentLocation: mapSearchViewModel.currentLocation)
                    
                    
                    
                    
                    VStack{
                        VStack(spacing:12) {
                            
                            HStack{
                                Image(systemName: "record.circle")
                                    .imageScale(.large)
                                
                                NavigationLink(destination:SelectSourceLocationView(isShowing: $isSourceSelected, viewModel: mapSearchViewModel),isActive:$isSourceSelected){
                                HStack {
                                    Text(directionEnv.sourceMapItem?.name ?? "Source")
                                    Spacer()
                                }
                                .padding().background(Color.white).cornerRadius(5)
                                }
                              
                                
                            }
                            
                            
                            
                            HStack{
                                
                                Image(systemName: "mappin.circle.fill")
                                    .imageScale(.large)
                                
                              
    
                                NavigationLink(destination:SelectDestinationLocationView(isShowing: $isDestinationSelected, viewModel: mapSearchViewModel),isActive:$isDestinationSelected){
                                HStack {
                                    Text(directionEnv.destinationMapItem?.name ?? "Destination")
                                    Spacer()
                                }
                                .padding().background(Color.white).cornerRadius(3)
                                }
                               
    //                                .padding(.horizontal,16)
    //                                .padding(.vertical,10)
    //                                .background(Color(UIColor.systemBackground))
    //                                .shadow(radius: 5)
    //                                .cornerRadius(5)
                            }
                            
                            
                        }
                        .frame(maxWidth:.infinity,maxHeight: reader.size.height * 0.1)
                        .padding(.vertical,16)
                        .padding()
                        .background(Color.blue)
                        .edgesIgnoringSafeArea([.horizontal])
                        .cornerRadius(3)
                        
//                        if mapSearchViewModel.isSearching{
//                            ProgressView()
//                        }
                        Spacer()
                        
                        if (directionEnv.sourceMapItem != nil) && directionEnv.destinationMapItem != nil{
                        HStack{
                            Spacer(minLength: 2)
                            Button(action:{self.ShowModel = true}){
                                Text("Show Routes")
                                    .font(.headline)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            Spacer(minLength: 2)
                        }
                        .padding()
                        }
                     

                    }
                    
                    
                  
                }
            }
            
            .sheet(isPresented: $ShowModel,onDismiss: {self.ShowModel = false}){
                
                VStack(alignment: .leading,spacing:8){
                    HStack{
                        VStack(alignment:.leading,spacing:4){
                            Text("overall Distance:\(String(format: "%.2f mi", (directionEnv.route!.distance * 0.00062137)))")
                        
                            Text("Estimated Time: "+" ".getTimeFromRoute(route: directionEnv.route!))
                        }
                        .padding()
                    }
                    .padding()
                    
                    List(directionEnv.route!.steps,id:\.self){item in
                        
                        HStack {
                            Text(item.instructions)
                            Spacer()
                            Text(String(format: "%.2f mi", (item.distance * 0.00062137)))
                            
//                            Text("\(item.distance * 0.00062137)")
//                                .foregroundColor(Color.gray)
                        }
                        .padding()
                    }
                    
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView()
    }
}


extension MKMapItem {
    func address() -> String {
        var addressString = ""
        if placemark.subThoroughfare != nil {
            addressString = placemark.subThoroughfare! + " "
        }
        if placemark.thoroughfare != nil {
            addressString += placemark.thoroughfare! + ", "
        }
        if placemark.postalCode != nil {
            addressString += placemark.postalCode! + " "
        }
        if placemark.locality != nil {
            addressString += placemark.locality! + ", "
        }
        if placemark.administrativeArea != nil {
            addressString += placemark.administrativeArea! + " "
        }
        if placemark.country != nil {
            addressString += placemark.country!
        }
        return addressString
    }
}

class DirectioinsEnviroment:ObservableObject{
    @Published var sourceMapItem:MKMapItem?
    @Published var destinationMapItem:MKMapItem?
    @Published var route:MKRoute?
    private var disposeBag = Set<AnyCancellable>()
    init() {
        Publishers.CombineLatest($sourceMapItem,$destinationMapItem).sink { (items) in
            
            let request = MKDirections.Request()
            request.source = items.0
            request.destination = items.1
            let directions = MKDirections(request: request)
            directions.calculate { (res, err) in
                if let err = err {print("error is \(err.localizedDescription)")
                    return}
                
                self.route = res?.routes.first
                print(self.route?.steps.forEach({ (step) in
                    print(step.instructions)
                }))
            }
        }
        .store(in: &disposeBag)
    }
}

extension String{
    func getTimeFromRoute(route:MKRoute)->String{
        var timeString = ""
               if route.expectedTravelTime > 3600 {
                   let h = Int(route.expectedTravelTime / 60 / 60)
                   let m = Int((route.expectedTravelTime.truncatingRemainder(dividingBy: 60 * 60)) / 60)
                   timeString = String(format: "%d hr %d min", h, m)
               } else {
                   let time = Int(route.expectedTravelTime / 60)
                   timeString = String(format: "%d min", time)
               }
        return timeString
    }
}
// for the places scrollView

//                        ScrollView(.horizontal,showsIndicators:true){
//                            HStack(spacing:16){
//                                ForEach(mapSearchViewModel.mapItems,id:\.self){item in
//                                    Button(action:{self.mapSearchViewModel.selectedMapItem = item }){
//                                        VStack(alignment: .leading, spacing: 4){
//                                            Text(item.name ?? "")
//                                                .font(.headline)
//                                            Text(item.placemark.title ?? "")
//                                        }
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
//                                    .foregroundColor(Color.black)
//                                    .padding()
//                                    .frame(width:200)
//                                    .background(Color.white)
//                                    .cornerRadius(5)
//                                }
//                            }
//                        }
//                        .padding(.horizontal,16)
//                        .padding(.vertical,12)
