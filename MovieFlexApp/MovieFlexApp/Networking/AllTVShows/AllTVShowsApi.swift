//
//  TVShowsApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/24/20.
//

import Foundation
import Combine
import Alamofire


class AllTVShowsApi:BaseApi<AllTVNetworking>{
    
    static let shared = AllTVShowsApi()
    private override init(){}
    
    func getTVShowsOnAir(page:Int = 1)->Future<TVResult,ApiError>{
        self.requst(target: .getTVShowsOnAir(page: page), responceClass: TVResult.self)
    }
    func getPopularTVShows(page:Int = 1)->Future<TVResult,ApiError>{
        self.requst(target: .getPopularTvShows(page: page), responceClass: TVResult.self)
    }
    func getTopRatedTVShows(page:Int = 1)->Future<TVResult,ApiError>{
        self.requst(target: .getTopRatedTVShows(page: page), responceClass: TVResult.self)
    }
    
}
