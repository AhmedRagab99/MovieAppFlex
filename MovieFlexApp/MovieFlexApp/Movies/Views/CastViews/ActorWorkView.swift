//
//  ActorWorkView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/8/20.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI



struct ActorWorkView: View {
    let gridItems = [GridItem(.adaptive(minimum: 90),spacing: 16)]
    @ObservedObject var castViewModel:CastViewModel

    var body: some View {
        LazyVGrid(columns:gridItems){
            ForEach(castViewModel.ActorWork,id:\.id) { item in
                VStack {
                    KFImage(item.posterURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .shadow(color:Color.primary,radius: 4)
                    
                    
                    VStack {
                        Text(item.originalTitle ?? "")
                            .font(.headline)
                        
                        
                        
                        Text(item.ratingText)
                            .font(.body)
                        
                        
                    }
                }
                
            }
        }
    }
}
