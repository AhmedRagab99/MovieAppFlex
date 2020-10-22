//
//  CastMovies.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation

struct ActorWork: Codable {
    let cast: [Work]?
}

// MARK: - Cast
struct Work: Codable {
    let character, creditID, posterPath: String?
    let id: Int?
    let video: Bool?
    let voteCount: Int?
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage, originalTitle: String?
    let popularity: Double?
    let title: String?
    let voteAverage: Double?
    let mediaType:String?
    let overview, releaseDate: String?
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? " ")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    enum CodingKeys: String, CodingKey {
        case character
        case mediaType = "media_type"
        case creditID = "credit_id"
        case posterPath = "poster_path"
        case id, video
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity, title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

