//
//  BaseApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/19/20.
//

import Foundation
import Alamofire
import Combine
class BaseApi<T:TargetType>{
    func requst<M:Decodable>(target:T,responceClass:M.Type)->Future<M,ApiError>{
        return Future({ promise in
            
            let method = Alamofire.HTTPMethod(rawValue: target.methods.rawValue)
            let headers = HTTPHeaders(target.headers ?? [:])
            let params = self.buildParams(task: target.task)
            
            AF.request(target.baseUrl+target.path,method: method,parameters: params.0,encoding: params.1,headers: headers)
             //   .validate(statusCode: 200...300)
                .responseJSON{(responce) in
                    
                    guard let jsonResponse = try? responce.result.get() else{
                        promise(.failure(.invalidEndpoint))
                        return
                    }
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                        promise(.failure(.noData))
                        return
                    }
                    let decoder = JSONDecoder()
                   // decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dataDecodingStrategy = .base64
                    do{
                        let jsonObject = try decoder.decode(M.self, from: jsonData)
                        promise(.success(jsonObject))
                    }catch(_){
                        promise(.failure(.invalidResponse))
                    }
                }
        })
    }
    
    private func buildParams(task:Task)->([String:Any],ParameterEncoding){
        switch task{
        case .requstPlain:
            return ([:],URLEncoding.default)
        case .requstParametares(parameters: let parameters, encoding: let encoding):
            return (parameters,encoding)
        case .requstQuareyParametares(parameters: let parameters, encoding: let encoding):
            return  (parameters,encoding)
        }
        
    }
}

