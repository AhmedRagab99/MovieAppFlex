//
//  UserViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 08/01/2021.
//

import Combine
import FirebaseAuth


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
