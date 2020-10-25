//
//  PopularView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/25/20.
//

import SwiftUI
struct PopularView: View {
    var movies:[Movie]
    var width:CGFloat
    var heigth:CGFloat
    var body: some View {
        ScrollView(.horizontal,showsIndicators:false) {
            HStack(spacing:2) {
                ForEach(movies,id:\.id){ m in
                    GeometryReader{ reader in
                        PopularCard(movie:m)
                            .rotation3DEffect(
                                Angle(degrees: Double(reader.frame(in: .global).minX - 30) / -20),
                                axis: (x: 0, y: 10, z: 10)
                            )
                            .padding(.horizontal)
                        
                    }
                    .frame(width: width, height: heigth)
                }
            }
            .padding(.top)
        }
        .listRowInsets(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
    }
}
