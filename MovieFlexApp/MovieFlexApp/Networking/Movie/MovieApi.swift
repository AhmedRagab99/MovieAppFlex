//
//  MovieApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Combine


class MovieApi:BaseApi<MovieNetworking>{
    
    static let shared = MovieApi()
    
   private override init() {}

    func getMovieRecomndation(movieId:Int,page:Int = 1)->Future<MovieResult,ApiError>{
        self.requst(target: .getMovieRecommendations(movieId: movieId, page: page), responceClass: MovieResult.self)
    }
    
    func getSimilarMovie(movieId:Int,page:Int = 1)->Future<MovieResult,ApiError>{
        self.requst(target: .getSimilarMovies(movieId: movieId, page: page), responceClass: MovieResult.self)
    }
    
    func getMovieCast(movieId:Int)->Future<CastModel,ApiError>{
        self.requst(target: .getMovieCast(movieId: movieId), responceClass: CastModel.self)
    }
    
    func getMovie(movieId:Int)->Future<Movie,ApiError>{
        self.requst(target: .getMovie(movieId: movieId), responceClass: Movie.self)
    }
}
