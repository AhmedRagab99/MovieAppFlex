//
//  ChatModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 28/01/2021.
//

import Combine
import FirebaseFirestoreSwift


struct ChatModel:Codable,Hashable,Identifiable{
    @DocumentID var id : String?
    let message:String?
    let senderId:String?
    let reciverId:String?
    let messageType:type
    let timeStamp:Date
    
    
}
enum type:String,CodingKey,Codable{
    case text = "text"
    case image = "image"
    case video = "video"
    case voice = "voice"
}



