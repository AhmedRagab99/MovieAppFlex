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
        
        GeometryReader {reader in
            VStack(alignment:.leading,spacing:8) {
                    KFImage(movie.posterURL)
                        .resizable()
                        .frame(width: 120)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                   
                    
                    VStack(spacing:2) {
                       
                        VStack {
                            Text(movie.title ?? "")
                                    .font(.subheadline)
                                    .bold()
                                .multilineTextAlignment(.leading)
                        }
                        
                            Text(movie.ratingText)
                                .font(.system(size: 12))
                        
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
