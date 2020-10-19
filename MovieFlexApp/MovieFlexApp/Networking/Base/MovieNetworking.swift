//
//  MovieNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/19/20.
//

import Foundation
import Alamofire



enum MovieNetworking{
    case signUp
//    case singIn(email:String,password:String)
}


extension MovieNetworking:TargetType{
    var methods: HTTPMethod {
        switch self{
        case .signUp:
//             ,.singIn:
            return .get
        }
    }
    
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self{
        case .signUp:
            return "/discover/movie"
        }
    }
    
 
    var task: Task {
    switch self{
        case .signUp:
            return .requstQuareyParametares(parameters: ["api_key":"\(constants.TMDBAPIKEY)"], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .signUp:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    
}
