//
//  PopularCard.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/25/20.
//

import SwiftUI
import KingfisherSwiftUI
struct PopularCard: View {
    let width = UIScreen.screens.first?.bounds.width ?? 0
    let height = UIScreen.screens.first?.bounds.height ?? 0
    var movie:Movie
    var body: some View {
            VStack(alignment:.leading,spacing:8) {
                KFImage(movie.posterURL)
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                              .cornerRadius(8)
                              .shadow(radius: 4)
//                    .frame(maxWidth: width, maxHeight:height - 15)
//                    .cornerRadius(30)
//                    .shadow(color:Color.secondary,radius: 10,x: 8,y: 8 )
               
                
                VStack {
                    Text(movie.title ?? "")
                        .font(.headline)
                    HStack(spacing:6) {
                        
                        Text(movie.ratingText)
                            .font(.subheadline)
                       
                        Text(movie.voteAverage?.description ?? "")
                    }
                }
               
                    
                
                
         
            
        }
            
            
    }
    
}

//struct PopularCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularCard()
//    }
//}
