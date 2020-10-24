//
//  TVShowsApi.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/24/20.
//

import Foundation
import Alamofire
import Combine

class TVShowsApi:BaseApi<TVShowsNetworking>{
    
    static let shared = TVShowsApi()
    private override init(){}
    
    
    func getSimilarTvShows(TVShowId:Int,page:Int = 1)->Future<TVResult,ApiError>{
        self.requst(target: .getSimilarTVShows(TVShowId: TVShowId, page: page), responceClass: TVResult.self)
    }
    //getTVShowRecommendations
    func getTVShowRecommendations(TVShowId:Int,page:Int = 1)->Future<TVResult,ApiError>{
        self.requst(target: .getTVShowRecommendations(TVShowId: TVShowId, page: page), responceClass: TVResult.self)
    }
    func getTVShowCast(TVShowId:Int)->Future<CastModel,ApiError>{
        self.requst(target: .getTVShowCast(TVShowId: TVShowId), responceClass: CastModel.self)
    }
}

