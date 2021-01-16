////
////  UserChatService.swift
////  MovieFlexApp
////
////  Created by Ahmed Ragab on 15/01/2021.
////
//
//import Combine
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//
//
//protocol UserChatServicesProtocol {
//    func createUser(_ user:UserData)->AnyPublisher<Void,FireStoreError>
//}
//
//
//final class UserChatService:UserChatServicesProtocol{
//
//    private let db = Firestore.firestore()
//    private let userPath = "Users"
//    func createUser(_ user: UserData) -> AnyPublisher<Void, FireStoreError> {
//        return Future<Void,FireStoreError>{ promise in
//            do {
//                _ = try self.db.collection(self.userPath).addDocument(from: user)
//                promise(.success(()))
//            } catch{
//                promise(.failure(.noAuthDataResult))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//}
//
//
//
//
//

