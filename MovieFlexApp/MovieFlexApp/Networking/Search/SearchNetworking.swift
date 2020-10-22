//
//  CastNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Alamofire

enum SearchNetworking{
    case combineSearch(query:String,page:Int = 1)
}

extension SearchNetworking:TargetType{
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self{
        case .combineSearch:
            return "/search/multi"
        }
    }
    
    var task: Task {
        switch self {
        
        case .combineSearch(let query, let page):
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY),"page":page,"query":query], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .combineSearch:
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
