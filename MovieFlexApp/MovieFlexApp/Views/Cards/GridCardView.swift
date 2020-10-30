//
//  ShowMoreCard.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/29/20.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct GridCardView: View {
    var item:Movie
    var body: some View {
        VStack {
            KFImage(item.posterURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .shadow(color:Color.primary,radius: 4)
            
            
            VStack {
                Text(item.title ?? "")
                    .font(.headline)
                HStack(spacing:6) {
                    
                    Text(item.ratingText)
                        .font(.subheadline)
                    
                    Text(item.voteAverage?.description ?? "")
                }
            }
        }
    }
}
