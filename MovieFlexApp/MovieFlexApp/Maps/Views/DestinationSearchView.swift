//
//  DestinationSearchView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import SwiftUI

struct DestinationSearchView:View{
    @Binding var isDestinationSelected:Bool
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @ObservedObject var mapSearchViewModel:MapSearchViewModel
    var body : some View {
        
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
        }
    }
}

