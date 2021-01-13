//
//  ProgressCircleView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/24/20.
//

import SwiftUI

struct ProgressCircleView: View {
    @State var progressValue: Float
       
       var body: some View {
           ZStack {
               Circle()
                .stroke(Color(UIColor.systemGray3), lineWidth: 12)
               
               Circle()
                .trim(from: 0, to: CGFloat(progressValue / 10))
                   .stroke(
             
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                       style: StrokeStyle(lineWidth: 10, lineCap: .round)
                   ).rotationEffect(.degrees(-90))
             
            Text("\(Int(progressValue * 10 ))%")
                      .font(.subheadline)
                
           }
         
           .padding()
       }
}



struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progressValue: 70.2)
    }
}
