////
////  TabButtonView.swift
////  MovieFlexApp
////
////  Created by Ahmed Ragab on 10/27/20.
////
//
//import SwiftUI
//
//struct TabButtonView: View {
//    @State var selected = false
////      @State var index:String
////      @State var scrollTabs:[String]
//    @ObservedObject var viewmodel:AllMoviesViewModel
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach(viewmodel.scroll_Tabs,id:\.self){ item in
//
//                    Button(action: {
//                    
//                        view = item.description
//
//                    }) {
//                        VStack {
//                            HStack {
//                                Spacer()
//                                Text(item.description)
//                                    .font(.body)
//                                Spacer()
//                            }
//                        }
//                        .padding(16)
//                    }
//                    .background(self.index == item.description ?
//                                    Color.primary: Color.secondary.opacity(0.3))
//                    .cornerRadius(20)
//                    .shadow(radius: 4)
//
//                }
//            }
//        }
//    }
//}
////
////struct TabButtonView_Previews: PreviewProvider {
////    static var previews: some View {
////        TabButtonView( index: "discover")
////            .preferredColorScheme(.dark)
////
////
////    }
////}
