//
//  UserChatService.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 15/01/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift



protocol UserChatServicesProtocol {
    func observerUserDocumnets(userId:UserId)->AnyPublisher<[UserData],MovieAppFlexError>
    func addChatMessage(userId:UserId,chat:ChatModel)->AnyPublisher<Void,Error>
    func observeChatDocuments(userId:String)->AnyPublisher<[ChatModel],MovieAppFlexError>
}


final class UserChatService:UserChatServicesProtocol{
    private let db = Firestore.firestore()
    private let userPath = "User"
    private let chatPath =  "Chat"
    
    func observeChatDocuments(userId: String) -> AnyPublisher<[ChatModel], MovieAppFlexError> {
        let query = db.collection(chatPath).order(by: "timeStamp",descending: false).whereField("senderId", isEqualTo: userId)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap{ snapshot -> AnyPublisher<[ChatModel],MovieAppFlexError> in
                do{
                    
                    let data  = try snapshot.documents.compactMap{
                        try $0.data(as:ChatModel.self)
                    }
                    return Just(data).setFailureType(to: MovieAppFlexError.self).eraseToAnyPublisher()
                    
                }
                catch {
                    return Fail(error:.defult(description:"parsing error")).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    
    func addChatMessage(userId: UserId, chat: ChatModel) -> AnyPublisher<Void, Error> {
        return Future<Void,Error>{promise in
            do{
                _ = try self.db.collection(self.chatPath).document(chat.id ?? "").setData(from: chat)
                promise(.success(()))
            } catch (let error){
                promise(.failure(error.localizedDescription as! Error))
            }
        }.eraseToAnyPublisher()
    }

    
    func observerUserDocumnets(userId: UserId) -> AnyPublisher<[UserData], MovieAppFlexError> {
        let query = db.collection(userPath)
            .whereField("userId", isEqualTo: userId)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap{ snapshot -> AnyPublisher<[UserData],MovieAppFlexError> in
                do{
                    
                    let data  = try snapshot.documents.compactMap{
                        try $0.data(as:UserData.self)
                    }
                    return Just(data).setFailureType(to: MovieAppFlexError.self).eraseToAnyPublisher()
                    
                }
                catch {
                    return Fail(error:.defult(description:"parsing error")).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
