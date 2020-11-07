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
    
    public var ratingText: String {
        let rating = Int(voteAverage ?? 0)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? " ")") ?? URL(string: "https://www.pexels.com/photo/person-holding-photo-of-single-tree-at-daytime-1252983/")!
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

