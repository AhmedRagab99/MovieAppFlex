//
//  MovieDetailView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import SwiftUI
import KingfisherSwiftUI
struct MovieDetailView: View {
    @Binding var isFullScreen: Bool
    var movie:Movie
    @StateObject var MovieViewModel = MovieViewModle()
    @State var op:CGFloat = 1
    
    var body: some View {
        NavigationView{
        VStack {
            List{
            
                KFImage(movie.posterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(30)
                    .shadow(radius: 4)
                    .padding()
                
                VStack(alignment: .leading){
                    DetailHeaderView(movie: movie)
                    
                    OverView(movie: movie)
                        .padding()
                    
                    // cast cells
                    MovieDeatilCastView(Cast: MovieViewModel.cast)
                        .padding()
                    
                    if MovieViewModel.similarMovies.count != 0{
                        SimilarMovieView(item: movie, similarMovies: MovieViewModel.similarMovies)
                    }
                }
            }
            .padding()
           
            .onAppear {
                MovieViewModel.getMovieCast(movieId: movie.id ?? 0)
                MovieViewModel.getSimilarMovies(movieId: movie.id ?? 0)
            }
        }
        .navigationBarTitle("Movie Detail")
        .navigationBarItems(leading:   Image(systemName: "clear.fill")
                                .imageScale(.large)
                                .padding()
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        self.isFullScreen.toggle()
                                        self.op = 0
                                    }
                                }, trailing:                Image(systemName: "heart.fill"))
            //                    .frame(width: 40, height:40, alignment: .leading))
        }
    }
}



struct OverView: View {
    var movie:Movie
    var body: some View {
        VStack {
            Text(movie.overview ?? "")
                
                .font(.title)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.primary.opacity(0.7))
        }
    }
}




