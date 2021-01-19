//
//  UserServices.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 07/01/2021.
//
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



typealias UserId = String




protocol AuthServiceProtocol{
    func currentUser()->AnyPublisher<User?,Never>
    func updateUserData(_ updatedata:[AnyHashable: Any],documentpath:String)->AnyPublisher<Void,Error>
    func signInAnonymasley()->AnyPublisher<User,MovieAppFlexError>
    func observeAuthStateChanges()->AnyPublisher<User?,Never>
    func createUser(_ user:UserData)->AnyPublisher<Void,Error>
    func linkAccountWithAnonmasyleyUser(email:String,password:String,name:String)->AnyPublisher<User?,MovieAppFlexError>
    func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, EmailAuthError>
    func signInWithEmail(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error>
    
}


final class AuthService:AuthServiceProtocol{
   
    
   
    
    private let db = Firestore.firestore()
    private let userPath = "User"
    
    func updateUserData(_ updatedata: [AnyHashable: Any],documentpath:String) -> AnyPublisher<Void, Error> {
       return  Future<Void, Error> { promise in
            self.db.collection(self.userPath).document(documentpath).updateData(updatedata) { error in
                 guard let error = error else {
                     promise(.success(()))
                     return
                 }
                 promise(.failure(error))
             }
         }.eraseToAnyPublisher()
     }
   
    
    
    func createUser(_ user: UserData) -> AnyPublisher<Void, Error> {
        return Future<Void,Error>{ promise in
            do {
                _ = try self.db.collection(self.userPath).document(Auth.auth().currentUser?.uid ?? "").setData(from: user)
           
                promise(.success(()))
            } catch (let error){
                promise(.failure(error.localizedDescription as! Error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signInWithEmail(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        Future<AuthDataResult, Error> {  promise in
            Auth.auth().signIn(withEmail: email, password: password){ auth, error in
                
                var newError:NSError
                if let err = error {
                    newError = err as NSError
                    var authError:EmailAuthError?
                    switch newError.code {
                    case 17009:
                        authError = .incorrectPassword
                    case 17008:
                        authError = .invalidEmail
                    case 17011:
                        authError = .accoundDoesNotExist
                    default:
                        authError = .unknownError
                    }
                    promise(.failure(authError!))
                }
                else if let auth = auth {
                    promise(.success(auth))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
    func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, EmailAuthError> {
        Future<AuthDataResult, EmailAuthError> { promise in
            Auth.auth().createUser(withEmail: email, password: password){ auth, error in
                
                var newError:NSError
                if let err = error {
                    newError = err as NSError
                    var authError:EmailAuthError?
                    switch newError.code {
                    case 17008:
                        authError = .invalidEmail
                        
                    default:
                        authError = .unknownError
                    }
                    promise(.failure(authError!))
                }
                else if let auth = auth {
                    promise(.success(auth))
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    func linkAccountWithAnonmasyleyUser(email: String, password: String,name:String) -> AnyPublisher<User?, MovieAppFlexError> {
        let emailCredntial = EmailAuthProvider.credential(withEmail: email, password: password)
        return Future<User?,MovieAppFlexError>{promise in
            Auth.auth().currentUser?.link(with: emailCredntial, completion: { (result, error) in
                if let error = error {
                    return promise(.failure(.defult(description: error.localizedDescription)))
                } else if let user = result?.user{
                    Auth.auth().updateCurrentUser(user) { (error) in
                        if let error = error{
                            return promise(.failure(.defult(description: error.localizedDescription)))
                        }else {
                            return promise(.success((user)))
                        }
                    }
                }
            })
            
        }.eraseToAnyPublisher()
        
    }
    
    
    func observeAuthStateChanges()->AnyPublisher<User?,Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    func currentUser() -> AnyPublisher<User?, Never> {
        return Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymasley() -> AnyPublisher<User, MovieAppFlexError> {
        return Future<User,MovieAppFlexError>{promise in
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error{
                    return promise(.failure(.auth(description:error.localizedDescription)))
                } else if let user = result?.user{
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}



