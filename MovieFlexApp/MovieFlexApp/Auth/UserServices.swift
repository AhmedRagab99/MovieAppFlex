//
//  UserServices.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 07/01/2021.
//
import Combine
import FirebaseAuth



enum MovieAppFlexError:LocalizedError{
    case auth(description:String)
    case `defult`(description:String? = nil )
    var errorDescription: String?{
        switch self{
        case let .auth(description):
            return description
        case let  .defult(description):
            return description ?? "Some Thing went Wrong"
        }
    }
    
}


protocol UserServicesProtocol{
    func currentUser()->AnyPublisher<User?,Never>
    func signInAnonymasley()->AnyPublisher<User,MovieAppFlexError>
    func observeAuthStateChanges()->AnyPublisher<User?,Never>
    func linkAccountWithAnonmasyleyUser(email:String,password:String,name:String)->AnyPublisher<User?,MovieAppFlexError>
    func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, EmailAuthError>
    func signInWithEmail(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error>
   
}


final class UserService:UserServicesProtocol{
    
    
     func signInWithEmail(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
         Future<AuthDataResult, Error> { [weak self] promise in
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
        Future<AuthDataResult, EmailAuthError> { [weak self] promise in
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

typealias UserId = String
final class UserViewModel:ObservableObject{
    
    private let userService:UserServicesProtocol
    private var disposeBag = Set<AnyCancellable>()
    @Published var emailText:String = ""
    @Published var passwordText:String = ""
    @Published var nameText:String = ""
    @Published var errorText:String = ""
    
    private let mode:Mode
    init(userService:UserServicesProtocol = UserService(),mode:Mode) {
        self.userService = userService
        self.mode = mode
    }
    
    
    func tappedActionMode(){
        switch mode {
        case .signOut:
            try? Auth.auth().signOut()
            
        case .linkAnonmasyley:
            userService.linkAccountWithAnonmasyleyUser(email: emailText, password: passwordText, name: nameText)
                .sink { [weak self] (completion) in
                    guard let self = self else {return}
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.errorText = error.localizedDescription
                        print(error.localizedDescription)
                    }
                } receiveValue: { (auth) in
                    print(auth?.email)
                }
                .store(in: &disposeBag)

        
        case .signIn:
            userService.signInWithEmail(withEmail: emailText, password: passwordText)
                .sink { (completion) in
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.errorText = error.localizedDescription
                        print(error.localizedDescription)
                    }
                } receiveValue: { (authData) in
                    print(authData.user.email)
                }
                .store(in: &disposeBag)

        
        case .signUp:
            userService.createUser(withEmail: emailText, password: passwordText)
                .sink { (completion) in
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.errorText = error.localizedDescription
                    }
                } receiveValue: { (authData) in
                    
                    print(authData.user.email ?? "")
                }
                .store(in:&disposeBag)
            
            
        default:
            print("asdasd")
        }
    }
    
    
    func getCurrentUserId()->AnyPublisher<UserId,MovieAppFlexError>{
        print("user will log in")
        return userService.currentUser().flatMap{user -> AnyPublisher<UserId,MovieAppFlexError> in
            if let userId = user?.uid{
                print("user is logged in")
                return Just(userId).setFailureType(to: MovieAppFlexError.self).eraseToAnyPublisher()
            } else {
                print("user is logged in anonymasley")
                return self.userService.signInAnonymasley().map{$0.uid}.eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
        
    }
}

extension UserViewModel{
    enum Mode{
        case signIn
        case signUp
        case signOut
        case linkAnonmasyley
    }
}
