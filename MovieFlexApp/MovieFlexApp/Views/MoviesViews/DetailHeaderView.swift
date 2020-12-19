//
//  DetailHeaderView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import SwiftUI

struct DetailHeaderView: View {
    @State var movie:Movie
    var body: some View {
        VStack(alignment:.leading,spacing:12) {
            Text(movie.title ?? "")
                .font(.title)
                .bold()
            
            Text(movie.ratingText)
                .font(.headline)
                .foregroundColor(.secondary)
            
            
            HStack {
                Text("popularity \(movie.popularity?.description ?? "")")
                    .font(.headline)
                    .foregroundColor(.secondary)
         Spacer()
                ProgressCircleView(progressValue: Float(movie.voteAverage ?? 0 * 10))
                    .frame(width:80,height:80,alignment:.center)
                    .padding()
                    .background(Color(UIColor.systemBackground))
                  
            }
        }
       
    }
}

