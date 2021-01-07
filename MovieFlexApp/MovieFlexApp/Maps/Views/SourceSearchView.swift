//
//  SourceSearchView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import SwiftUI

struct SourceSearchView:View{
    @Binding var isSourceSelected:Bool
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @ObservedObject var mapSearchViewModel:MapSearchViewModel
    var body :some View{
        
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
    }
}

