//
//  TVNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/24/20.
//

import Foundation
import Alamofire



enum AllTVNetworking{
    case getPopularTvShows(page:Int = 1)
    case getTopRatedTVShows(page:Int = 1)
    
}


extension AllTVNetworking:TargetType{
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self{
        case .getPopularTvShows:
            return "/tv/popular"
        case .getTopRatedTVShows:
            return "/tv/top_rated"
        }
    }
    
    var task: Task {
        switch self{
        case .getPopularTvShows(let page),.getTopRatedTVShows(let page):
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY),"page":(page)] , encoding:.queryString)
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
        case .getPopularTvShows:
            return .get
        default:
            return .get
        }
    }
    
    
}
