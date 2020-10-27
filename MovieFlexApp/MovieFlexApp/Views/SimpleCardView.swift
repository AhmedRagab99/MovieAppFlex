//
//  SimpleCardView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/26/20.
//

import SwiftUI
import KingfisherSwiftUI
struct SimpleCardView: View {
    var movies:[Movie]
    var title:String
    var loading:Bool
    
    var body: some View {
        VStack {
            if loading{
                ProgressView().frame(width: 200, height: 200, alignment: .center)
            }
            HStack{
                Text(title)
                    .font(.title)
                Spacer()
                Button(action: {}) {
                    Text("More...")
                        .font(.headline)
                }
            }
            ScrollView(.vertical,showsIndicators:false) {
                
              
                    LazyVGrid(columns:[GridItem(.adaptive(minimum: 130),spacing: 8)],spacing:12){
                       
                        ForEach(movies,id:\.id) { item in
                           
                            VStack {
                                KFImage(item.posterURL)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(20)
                                    .shadow(color:Color.primary,radius: 4)
                                
                                
                                VStack {
                                    Text(item.title ?? "")
                                        .font(.headline)
                                    HStack(spacing:6) {
                                        
                                        Text(item.ratingText)
                                            .font(.subheadline)
                                       
                                        Text(item.voteAverage?.description ?? "")
                                    }
                                }
                            }
                    }
                    .padding()
                    .frame(maxWidth:.infinity,maxHeight: 500)
                    .animation(.easeIn)
                }
                
            }
        }
    }
}

//struct SimpleCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleCardView()
//    }
//}
