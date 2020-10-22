//
//  CastApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Combine



class CastApi:BaseApi<CastNetworking>{
    
    static let shared = CastApi()
    
   private override init() {}
    
    
    func getActorDetail(castId:Int)->Future<ActorDetail,ApiError>{
        self.requst(target: .getPersonDetail(castId: castId), responceClass: ActorDetail.self)
    }
    func getActorWork(castId:Int)->Future<ActorWork,ApiError>{
        self.requst(target: .getActorWork(castId: castId), responceClass: ActorWork.self)
    }
    
}
