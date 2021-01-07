//
//  ShowMoreCellView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI


struct ShowMoreCellView:View{
    var movie:Movie
    var body :some View{
        HStack{
            KFImage(movie.posterURL)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Rectangle())
                .cornerRadius(20)
                .shadow(radius: 2.5)
                .padding()
            
            VStack(alignment:.leading) {
                Text(movie.title ?? "")
                    .font(.headline)
                HStack(spacing:6) {
                    
                    Text(movie.ratingText)
                        .font(.body)
                    
                    
                }
            }
            Spacer()
            
            ProgressCircleView(progressValue: Float(movie.voteAverage ?? 0 * 10))
                .frame(maxWidth:80,maxHeight:80,alignment:.trailing)
                .padding()
                .background(Color(UIColor.systemBackground))
        }
    }
}

