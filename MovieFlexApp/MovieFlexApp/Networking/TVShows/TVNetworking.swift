//
//  TVNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/24/20.
//

import Foundation
import Alamofire


enum TVShowsNetworking{
    case getTVShowRecommendations(TVShowId:Int,page:Int = 1)
    case getSimilarTVShows(TVShowId:Int,page:Int = 1)
    case getTVShowCast(TVShowId:Int)
//    case getTVShow(TVShowId:Int)
}

extension TVShowsNetworking:TargetType{
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self {
        case .getSimilarTVShows(let TVShowId,_):
            return "/tv/\(TVShowId)/similar"
        case .getTVShowRecommendations(let TVShowId,_):
            return "/tv/\(TVShowId)/recommendations"
        case .getTVShowCast(let TVShowId ):
            return "/tv/\(TVShowId)/credits"
      
        }
    }
    
    var task: Task {
        switch self{
        case .getSimilarTVShows(_, let page),.getTVShowRecommendations(_, let page):
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY),"page":(page)] , encoding:.queryString)
        case .getTVShowCast:
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY)], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    var methods: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    
}
