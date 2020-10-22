//
//  MovieNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Alamofire

enum MovieNetworking{
    case getMovieRecommendations(movieId:Int,page:Int = 1)
    case getSimilarMovies(movieId:Int,page:Int = 1)
    case getMovieCast(movieId:Int)
    case getMovie(movieId:Int)
}


extension MovieNetworking:TargetType{
    var baseUrl: String {
        return constants.BASEURL
    }
    
    
    var path: String {
        switch self{
        case .getMovieRecommendations(let movieId,_):
            return "/movie/\(movieId)/recommendations"
        case .getSimilarMovies(let movieId,_):
            return "/movie/\(movieId)/similar"
        case .getMovieCast(let movieId):
            return "/movie/\(movieId)/credits"
        case .getMovie(let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    var task: Task {
        switch self{
        case .getMovieRecommendations(_, let page),.getSimilarMovies(_, page: let page):
            return .requstQuareyParametares( parameters: ["api_key":(constants.TMDBAPIKEY),"page":(page)], encoding: .queryString)
        case .getMovieCast,.getMovie:
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY)], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getMovieRecommendations,.getSimilarMovies,.getMovieCast,.getMovie:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    var methods: HTTPMethod {
        switch self{
        case .getMovieRecommendations,.getSimilarMovies,.getMovieCast,.getMovie:
            return .get
        }
    }
}


