//
//  MovieNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/19/20.
//

import Foundation
import Alamofire

enum AllMovieNetworking{
    case discover(page:Int = 1)
    case getUpcomingMovies(page:Int = 1)
    case getTopRatedMovies(page:Int = 1)
    case getPopularMovies(page:Int = 1)
   
}


extension AllMovieNetworking:TargetType{
    var methods: HTTPMethod {
        switch self{
        case .discover,.getUpcomingMovies,.getTopRatedMovies,.getPopularMovies:
            return .get
        }
    }
    
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self{
        case .discover:
            return "/discover/movie"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getPopularMovies:
            return "/movie/popular"
            
        }
    }
    
    
    var task: Task {
        switch self{
        case .discover(let page),.getUpcomingMovies(let page),.getTopRatedMovies(let page),.getPopularMovies(let page):
            return .requstQuareyParametares(parameters: ["api_key":"\(constants.TMDBAPIKEY)","page":"\(page)"], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .discover,.getUpcomingMovies,.getTopRatedMovies,.getPopularMovies:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    
}
