//
//  MovieDetailView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/30/20.
//

import SwiftUI
import KingfisherSwiftUI
struct MovieDetailView: View {
    @Binding var isFullScreen: Bool
    var movie:Movie
    @State var op:CGFloat = 1
    var body: some View {
        ZStack {
            KFImage(movie.posterURL)
                .onTapGesture {
                    withAnimation(.spring()){
                    self.isFullScreen.toggle()
                        self.op = 0
                    }
                }
        }
        .opacity(Double(op))
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    @State var t = false
//    static var previews: some View {
//        MovieDetailView(isFullScreen: false)
//    }
//}
//
//struct ContentView: View {
//    @State private var isFullScreen = false
//    var body: some View {
//        ZStack{
//        Color.yellow.edgesIgnoringSafeArea(.all)
//        Text("Hello, FullScreen!")
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.green)
//            .cornerRadius(8)
//            .fullScreenCover(isPresented: $isFullScreen) {
//                FullScreen(isFullScreen: $isFullScreen)
//            }
//            .onTapGesture {
//                isFullScreen.toggle()
//            }
//    }
//    }
//}
//
//struct FullScreen: View {
//    @Binding var isFullScreen: Bool
//
//    var body: some View {
//        ZStack {
//            Color.red.edgesIgnoringSafeArea(.all)
//            Text("This is full screen!!")
//                .onTapGesture {
//                    self.isFullScreen.toggle()
//                }
//
//        }
//    }
//}
