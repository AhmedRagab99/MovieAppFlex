//
//  ActorHeaderView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/8/20.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI


struct ActorHeaderView: View {
    let screenHiegt:CGFloat
    @ObservedObject var viewModel:CastViewModel
    
    @Binding var isBlured:Bool
    var body: some View {
      
        KFImage(viewModel.castInfo?.ProfilePathUrl)
                .resizable()
                .frame( maxWidth:.infinity, minHeight: 80, maxHeight: screenHiegt / 2, alignment: .center)
                .cornerRadius(30)
                .overlay( VStack(alignment: .center){
                    Spacer()
                    Text(viewModel.castInfo?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .opacity(isBlured ? 0:1)
                       .foregroundColor(Color.purple)
                    Spacer().frame(width: 20, height: 20)
                }, alignment: .center)
        
               // .edgesIgnoringSafeArea(.all)

            
      
    }
}

