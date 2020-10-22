//
//  MovieApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/19/20.
//

import Foundation
import Combine


class AllMovieApi:BaseApi<AllMovieNetworking>{
    
    
    static let shared = AllMovieApi()
    
   private override init() {}

    

    
    func discoverMovies( page:Int=1)->Future<MovieResult,ApiError>{
        self.requst(target: .discover(page: page), responceClass: MovieResult.self)
    }
    
    func getUpcomingMovies( page:Int=1)->Future<MovieResult,ApiError>{
        self.requst(target: .getUpcomingMovies(page: page), responceClass: MovieResult.self)
    }
    
    func getTopRatedMovies(page:Int = 1)->Future<MovieResult,ApiError>{
        self.requst(target:.getTopRatedMovies(page: page),responceClass: MovieResult.self)
    }
    
    func getPopularMovies(page:Int = 1)->Future<MovieResult,ApiError>{
        self.requst(target:.getPopularMovies(page: page),responceClass:MovieResult.self)
    }
    
}
