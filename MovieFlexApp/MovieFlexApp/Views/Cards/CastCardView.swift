//
//  CastCardView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI


struct CastCardView: View {
    var cast:[Cast]
    var body: some View {
        HStack{
            ForEach(cast,id:\.id) { item in
                VStack {
                    KFImage(item.ProfilePathUrl)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 150, height: 150)
                    Text(item.name ?? "")
                        .font(.title2)
                        .foregroundColor(Color.primary.opacity(0.6))
                    
                }
                .padding()
            }
        }
    }
}
