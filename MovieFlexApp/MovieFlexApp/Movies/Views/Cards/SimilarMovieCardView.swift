//
//  SimilarMovieCardView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import SwiftUI
import KingfisherSwiftUI


struct SimilarMovieCardView: View {
    var item:Movie
    @State var isFullScreen = false

    var body: some View {
        VStack {
            KFImage(item.posterURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture{
              
                  
                }
                
                .cornerRadius(20)
            
            VStack {
                Text(item.title ?? "")
                    .font(.headline)
                
            }
        }
      
    }
}
