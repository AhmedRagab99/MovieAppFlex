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
    
    @ObservedObject var viewModel:AllMoviesViewModel
    @State var show = false
    @State  var page:Int
    @State var title:String
    @State var index = 0
  
    var body: some View {
        VStack {
            ScrollView{
                SearchBarView(placeholder: "Search for a movie ", text: $viewModel.seearchText)
                    .padding(.horizontal)
                ForEach(viewModel.filterdMovies.count != 0 ? viewModel.filterdMovies:movies,id:\.id) { item in
                ShowMoreCellView(movie: item,show: $show)
                    
                .padding(.horizontal,4)

               
            }
          
            }
            .padding([.bottom,.horizontal])
            Spacer()
    
        }
    }
}
