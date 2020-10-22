//
//  CastNetworking.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Alamofire

enum CastNetworking{
    case getPersonDetail(castId:Int)
    case getActorWork(castId:Int)
}

extension CastNetworking:TargetType{
    var baseUrl: String {
        return constants.BASEURL
    }
    
    var path: String {
        switch self{
        case .getPersonDetail(let castId):
            return "/person/\(castId)"
        case .getActorWork(let castId):
            return "/person/\(castId)/combined_credits"
        }
    }
    
    var task: Task {
        switch self {
        
        case .getPersonDetail,.getActorWork:
            return .requstQuareyParametares(parameters: ["api_key":(constants.TMDBAPIKEY)], encoding: .queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getPersonDetail,.getActorWork:
            return ["content-type":"application/json;charset=utf-8"]
        }
    }
    
    var methods: HTTPMethod {
        switch self {
        case .getPersonDetail:
            return .get
        default:
            return .get
        }
    }
    
    
}
