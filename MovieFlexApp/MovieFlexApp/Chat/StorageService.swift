//
//  StorageService.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 16/01/2021.
//

import Combine
import FirebaseStorage

protocol StorageServicesProtocol {
    func putData(_ uploadData:Data,refPath:String)->AnyPublisher<String,Error>
    func downloadUrl(refPath:String)->AnyPublisher<URL,Error>
}



final class StorageServices:StorageServicesProtocol{
    
    
    func putData(_ uploadData: Data,refPath:String) -> AnyPublisher<String, Error> {
        
        return Future<String, Error> {  promise in
            Storage.storage().reference(withPath:refPath).putData(uploadData, metadata:nil) { _, error in
                if let error = error{promise(.failure(error))}
                promise(.success("Data uploaded Successfuly"))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func downloadUrl(refPath:String) -> AnyPublisher<URL, Error> {
        Future<URL, Error> {  promise in
            Storage.storage().reference(withPath: refPath).downloadURL { url, error in
                guard let error = error else {
                    if let url = url {
                        promise(.success(url))
                    }
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    
}
