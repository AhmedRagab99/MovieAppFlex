//
//  DirectionDetailView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import SwiftUI

struct DirectionDetailView:View{
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    var body:some View{
        VStack(alignment: .leading,spacing:8){
            HStack{
                VStack(alignment:.leading,spacing:4){
                    Text("overall Distance:\(String(format: "%.2f mi", (directionEnv.route!.distance * 0.00062137)))")
                
                    Text("Estimated Time: "+" ".getTimeFromRoute(route: directionEnv.route!))
                }
                .padding()
            }
            .padding()
            
            List(directionEnv.route!.steps,id:\.self){item in
                
                HStack {
                    Text(item.instructions)
                    Spacer()
                    Text(String(format: "%.2f mi", (item.distance * 0.00062137)))
                    

                }
                .padding()
            }
            
        }
    }
}
