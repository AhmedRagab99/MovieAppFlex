//
//  DocumentSnapshotListener.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 28/01/2021.
//

import Combine
import Firebase


extension Publishers{
    
    struct DocumnetSnapshotPublisher:Publisher{
        typealias Output = DocumentSnapshot
        typealias Failure = MovieAppFlexError
        
        private let documentRef:DocumentReference
        init(documnetRefrence:DocumentReference) {
            self.documentRef = documnetRefrence
        }
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let documentSubscription = DocumnetSnapshotSubscriber(subscriber: subscriber, documentRefrence: documentRef)
            subscriber.receive(subscription: documentSubscription)
        }
    }
    
    class DocumnetSnapshotSubscriber<S:Subscriber>:Subscription where S.Input == DocumentSnapshot,S.Failure == MovieAppFlexError{
        private var subscriber:S?
        private var listener:ListenerRegistration?
        
        init(subscriber:S,documentRefrence:DocumentReference) {
            listener = documentRefrence.addSnapshotListener({ (snapshot, error) in
                if let error = error{
                    subscriber.receive(completion: .failure(.defult(description: error.localizedDescription)))
                } else if let snapshot =  snapshot{
                   _ =  subscriber.receive(snapshot)
                } else  {
                    subscriber.receive(completion: .failure(.defult(description: "another error")))
                }
            })
        }
        
        
        
        
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        func cancel() {
            subscriber = nil
            listener?.remove()
            listener = nil
        }
        
        
    }
    
}
 

