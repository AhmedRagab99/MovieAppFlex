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
    @State var searchText:String = ""
    var body: some View {
        
        
        
        
        List(movies,id:\.id) { item in
            HStack{
                KFImage(item.posterURL)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Rectangle())
                    .cornerRadius(20)
                    .shadow(color:Color.primary,radius: 5)
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
            .onAppear{
                if item == movies.last{
                    print(viewModel.page)
                    viewModel.page = viewModel.page + 1
                    print(viewModel.page)
                    viewModel.fetchDiscoverMovies(page: viewModel.page)
                    
                    
                }
            }
        }
    }
}

//struct ShowMoreMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowMoreMoviesView(movies: <#[Movie]#>)
//    }
//}
