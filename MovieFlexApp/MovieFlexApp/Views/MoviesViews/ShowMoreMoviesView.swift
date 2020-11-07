//
//  ShowMoreMoviesView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/27/20.
//

import SwiftUI
import KingfisherSwiftUI

struct ShowMoreMoviesView: View {
     var movies:[Movie]
    @State var movie:Movie?
    @ObservedObject var viewModel:AllMoviesViewModel
    @State var show = false
   @State  var page:Int
    @State var title:String
    @State var searchText:String = ""
    var body: some View {
        List(movies,id:\.id) { item in
            HStack{
                KFImage(item.posterURL)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Rectangle())
                    .cornerRadius(20)
                    .shadow(radius: 2.5)
                    .padding()
                
                VStack(alignment:.leading) {
                    Text(item.title ?? "")
                        .font(.headline)
                    HStack(spacing:6) {
                        
                        Text(item.ratingText)
                            .font(.body)
                        
                        Text(item.voteAverage?.description ?? "")
                    }
                }
                
            }
            .onTapGesture{
                withAnimation(.spring()){
                self.show.toggle()
                self.movie = item
                }
            }
            
            .onAppear{
                if item == movies.last{
                    print(viewModel.page)
                page = page + 1
                    print(viewModel.page)
                    if title == "Discover"{
                    viewModel.fetchDiscoverMovies(page: page)
                    } else if title == "Upcoming"{
                        viewModel.fetchUpComeingMovies(page: page)

                    }
                    else{
                        viewModel.getTopRatedMovies(page: page)

                    }
                }
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $show) {

            MovieDetailView(isFullScreen: $show, movie: movie ?? movies.first!)
                .animation(.easeOut(duration: 0.3))
                
                }
//        .fullScreenCover(isPresented: $show) {
//
////            MovieDetailView(isFullScreen: $show, movie: self.movie ?? movies.first!)
//            Test(isFullScreen: $show, movie: movie ?? movies.first!)
//                .transition(.opacity)
//                }
    }
}
