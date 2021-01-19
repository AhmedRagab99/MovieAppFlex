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
}


final class UserChatService:UserChatServicesProtocol{
    private let db = Firestore.firestore()
    private let userPath = "User"

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






