//
//  SearchApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation
import Combine



class SearchApi:BaseApi<SearchNetworking>{
    
    static let shared = SearchApi()
    
   private override init() {}
    
    
    func multiSearch(query:String,page:Int = 1)->Future<SearchModel,ApiError>{
        self.requst(target: .combineSearch(query: query, page: page), responceClass: SearchModel.self)
    }
    
}

