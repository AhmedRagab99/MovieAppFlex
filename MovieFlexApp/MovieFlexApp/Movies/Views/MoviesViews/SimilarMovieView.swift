//
//  SimilarMovieView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import Foundation
import SwiftUI



struct SimilarMovieView: View {
    var item:Movie
    var similarMovies:[Movie]
    var body: some View {
        VStack {
            HStack {
                Text("Similar Movies")
                    .font(.title)
                Spacer()
                Text("____________")
                
            }
            .padding()
            LazyVGrid(columns:[GridItem(.adaptive(minimum: 80),spacing: 12)],spacing:12){
                ForEach(similarMovies,id:\.id){item in
                    SimilarMovieCardView(item: item)
                }
            }
            .padding()
        }
    }
}
