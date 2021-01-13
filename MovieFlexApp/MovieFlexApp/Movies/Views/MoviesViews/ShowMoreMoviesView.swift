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
        VStack {
            
            SearchBarView(placeholder: "Search for a movie ", text: $viewModel.seearchText)
                .padding(.horizontal)
            List(viewModel.filterdMovies.count != 0 ? viewModel.filterdMovies:movies,id:\.id) { item in
                ShowMoreCellView(movie: item,show: $show)
                .padding(.horizontal,4)
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
       
        }
        
    }
}
