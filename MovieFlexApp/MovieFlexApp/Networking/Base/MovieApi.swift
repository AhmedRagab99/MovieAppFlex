//
//  MovieApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/19/20.
//

import Foundation
import Combine


class MovieApi:BaseApi<MovieNetworking>{
    
    
    static let shared = MovieApi()
    
   private override init() {}

    
//    
//    func signUp(email:String,name:String,picuture:String,password:String,pio:String,completion:@escaping (Result<Message?,ApiError>)->Void){
//        self.fetchData(target: .signUp(name: name, email: email, piciture: picuture, password: password,pio:pio), responceClass: Message.self) { (result) in
//            completion(result)
//        }
//    }
    
    func discoverMovies()->Future<MovieResult,ApiError>{
        self.requst(target: .signUp, responceClass: MovieResult.self)
    }
    
}
