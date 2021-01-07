//
//  MapSearchView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 12/27/20.
//

import SwiftUI
import MapKit
import Combine

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
                   
                            SourceSearchView(isSourceSelected: $isSourceSelected, mapSearchViewModel: mapSearchViewModel)

                            DestinationSearchView(isDestinationSelected: $isDestinationSelected, mapSearchViewModel: mapSearchViewModel)
                            
                            
                        }
                        .frame(maxWidth:.infinity,maxHeight: reader.size.height * 0.1)
                        .padding(.vertical,16)
                        .padding()
                        .background(Color.blue)
                        .edgesIgnoringSafeArea([.horizontal])
                        .cornerRadius(3)

                        
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
            .padding(.bottom)
            .sheet(isPresented: $ShowModel,onDismiss: {self.ShowModel = false}){
                DirectionDetailView()
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
