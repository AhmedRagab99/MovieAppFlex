//
//  SearchModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

struct SearchModel: Codable {
    let page, totalResults, totalPages: Int?
    let results: [SearchResult]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchResult: Codable {
    let mediaType:MediaType?
    let name: String?
    let voteCount: Int?
    let backdropPath: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath, title: String?

    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? " ")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case name
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case title
    }
}
