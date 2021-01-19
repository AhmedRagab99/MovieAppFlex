//
//  QuerySnaphotListner.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 18/01/2021.
//

import Combine
import Firebase


extension Publishers{
    struct  QuerySnapshotPublisher:Publisher {
        typealias Output = QuerySnapshot
        typealias Failure = MovieAppFlexError
        private let query:Query
        
        init(query:Query) {
            self.query = query
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let querySnapshotSubscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: querySnapshotSubscription)
        }
    }
    
    
//    public func getDocuments(source: FirestoreSource = .default) -> AnyPublisher<QuerySnapshot, Error> {
//            Future<QuerySnapshot, Error> { promise in
//                 getDocuments(source: source, completion: { (snapshot, error) in
//                    if let error = error {
//                        promise(.failure(error))
//                    } else if let snapshot = snapshot {
//                        promise(.success(snapshot))
//                    } else {
//                        promise(.failure(FirestoreError.nilResultError))
//                    }
//                })
//            }.eraseToAnyPublisher()
//        }
        
      
    
    class QuerySnapshotSubscription<S:Subscriber>: Subscription where S.Input == QuerySnapshot, S.Failure == MovieAppFlexError{
        
        private var subscriber:S?
        private var listener:ListenerRegistration?
        init(subscriber:S,query:Query) {
            listener = query.addSnapshotListener({ (querySnapshot, error) in
                if let error = error{
                    subscriber.receive(completion: .failure(.defult(description: error.localizedDescription)))
                } else if let querySnapshot = querySnapshot{
                    _ = subscriber.receive(querySnapshot)
                } else {
                    subscriber.receive(completion: .failure(.defult()))
                }
            })
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            listener = nil
        }
    }
    
    
    
}

