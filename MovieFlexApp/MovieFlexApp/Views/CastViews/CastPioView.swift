//
//  CastPioView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/8/20.
//

import Foundation
import SwiftUI

struct CastPioView: View {
    @ObservedObject var castViewModel:CastViewModel
    var body: some View {
        List {
            if castViewModel.castInfo?.popularity?.description != " "{
                HStack{
                    Text("Actor Rating")
                    Spacer()
                    Text("\(castViewModel.castInfo?.popularity ?? 0)")
                    
                }
                .padding()
            }
            
            if  castViewModel.castInfo?.birthday != " "{
                HStack{
                    Text("Date Of Birth")
                        .frame(alignment: .leading)
                    Spacer()
                    Text(castViewModel.castInfo?.birthday ?? "")
                }
                .padding()
            }
            
            
            if castViewModel.castInfo?.biography != " "{
                HStack{
                    Text("biography")
                        .frame(alignment: .leading)
                    Spacer()
                    
                    VStack {
                        Text(castViewModel.castInfo?.biography ?? "")
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            
            if castViewModel.castInfo?.knownForDepartment != " "{
                HStack{
                    Text("knownForDepartment")
                    Spacer()
                    Text(castViewModel.castInfo?.knownForDepartment ?? " ")
                }
                .padding()
            }
        }
        .padding()
        
    }
}
