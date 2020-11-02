//
//  MovieDeatilCastView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import SwiftUI

struct MovieDeatilCastView: View {
    var Cast:[Cast]
    var body: some View {
        VStack() {
            
            HStack {
                Text("Cast")
                    .font(.title)
                Spacer()
                Text("_______________")
                
            }
            .padding()
            ScrollView(.horizontal,showsIndicators:false){
                
                CastCardView(cast: Cast)
            }
        }
        
    }
}
