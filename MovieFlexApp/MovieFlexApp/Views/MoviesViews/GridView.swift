//
//  SimpleCardView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/26/20.
//

import SwiftUI
import KingfisherSwiftUI
struct GridView: View {
    var movies:[Movie]
    var title:String
    @State var movie:Movie?
    var loading:Bool
    @State var showMoreUpcoming = false
    @ObservedObject var viewModel:AllMoviesViewModel
    @State var show = false
    
    var body: some View {
        VStack {
            if loading{
                ProgressView().frame(width: 200, height: 200, alignment: .center)
            }
            HStack{
                Text(title)
                    .font(.title)
                Spacer()
                Button(action: {
                    if title == "Upcoming"{
                        self.showMoreUpcoming = true
                    }
                    
                }) {
                    NavigationLink(destination: ShowMoreMoviesView(movies: movies, viewModel: viewModel, page: 1, title: "Upcoming")) {
                                      
                    Text("More...")
                        .font(.headline)
                }
                }
            }
            ScrollView(.vertical,showsIndicators:false) {
                
                
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 130),spacing: 8)],spacing:12){
                    
                    ForEach(movies,id:\.id) { item in
                        
                        GridCardView(item: item)
                            .onTapGesture{
                                self.movie = item
                                self.show.toggle()
                            }
                          
                    }
                    .padding()
                    .frame(maxWidth:.infinity,maxHeight: 500)
                }
                
            }
        }
        .sheet(isPresented: $show) {

            MovieDetailView(isFullScreen: $show, movie: movie ?? movies.first!)
                
                }
    }
}


