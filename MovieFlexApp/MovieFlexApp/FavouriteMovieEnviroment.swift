//
//  FavouriteMovieEnviroment.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 14/01/2021.
//

import Combine

class FavouriteMovieEnviroment:ObservableObject{
    @Published var favouriteMovies:[Movie] = []
}
