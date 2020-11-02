//
//  CastModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/22/20.
//

import Foundation



    struct ActorDetail: Codable {
        let birthday, knownForDepartment: String?
        let id: Int?
        let name: String?
        let gender: Int?
        let biography: String?
        let popularity: Double?
        let placeOfBirth, profilePath: String?

        
        public var ProfilePathUrl: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
        }
        
        enum CodingKeys: String, CodingKey {
            case birthday
            case knownForDepartment = "known_for_department"
            case id, name, gender, biography, popularity
            case placeOfBirth = "place_of_birth"
            case profilePath = "profile_path"
        }
    }



struct CastModel:Codable{
    let cast:[Cast]?
}
struct Cast:Codable{
    let castId:Int?
    let character:String?
    let id:Int?
    let name:String?
    let profilePath:String?
    
    
    public var ProfilePathUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")") ?? URL(string: "https://tse2.mm.bing.net/th?id=OIP.PB3QCTk1kCZZ6ZvvVqpM5gHaHa&pid=Api&P=0&w=500&h=500")!
    }
    
    enum CodingKeys:String,CodingKey{
        case castId = "cast_id"
        case character, id, name
        case profilePath = "profile_path"
    }
 
}
