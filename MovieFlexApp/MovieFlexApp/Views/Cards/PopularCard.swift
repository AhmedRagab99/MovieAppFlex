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
//    @State var showDetail:Bool
    var body: some View {
        
            VStack(alignment:.leading,spacing:8) {
                KFImage(movie.posterURL)
                    .resizable()
                    .frame(width: 120, height: 200)
                    .cornerRadius(10)
                    .shadow(radius: 5)
               
                
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
