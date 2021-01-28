//
//  User.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 15/01/2021.
//

import Foundation
import FirebaseFirestore



struct UserData:Codable{
    let userId:String?
    let userName:String?
    let userEmail:String?
    let userImageUrl:String?
    var createdAt:Date
}
