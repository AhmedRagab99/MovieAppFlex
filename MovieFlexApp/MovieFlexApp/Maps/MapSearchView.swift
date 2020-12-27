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
    @State var dummyAnnotaions:MKPointAnnotation?
    @State var searchtext  = ""
    var body: some View {
        ZStack(alignment:.top){
            MapViewContainer(annotaions: mapSearchViewModel.annotaions,selectedMapItem: mapSearchViewModel.selectedMapItem,currentLocation: mapSearchViewModel.currentLocation)
               
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    TextField("Search  for a place ",text:$mapSearchViewModel.searchingQuearyText,onCommit:{UIApplication.shared.windows.first?.window?.endEditing(true)})
                        .padding(.horizontal,16)
                        .padding(.vertical,10)
                        .background(Color.white)
                        .cornerRadius(15)
                        
                    
                    
                }
                .padding()
                .shadow(radius: 5)
                if mapSearchViewModel.isSearching{
                    ProgressView()
                }
                Spacer()
                ScrollView(.horizontal,showsIndicators:true){
                    HStack(spacing:16){
                        ForEach(mapSearchViewModel.mapItems,id:\.self){item in
                            Button(action:{self.mapSearchViewModel.selectedMapItem = item }){
                                VStack(alignment: .leading, spacing: 4){
                                    Text(item.name ?? "")
                                        .font(.headline)
                                    Text(item.placemark.title ?? "")
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color.black)
                            .padding()
                            .frame(width:200)
                            .background(Color.white)
                            .cornerRadius(5)
                        }
                    }
                }
                .padding(.horizontal,16)
                .padding(.vertical)
            }
          
            
            
        }
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}

