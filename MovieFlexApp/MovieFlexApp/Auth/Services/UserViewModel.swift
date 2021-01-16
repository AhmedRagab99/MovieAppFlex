//
//  UserViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 08/01/2021.
//

import Combine
import FirebaseAuth
import Firebase




final class UserViewModel:ObservableObject{
    
    private let userService:UserServicesProtocol
    
    
    private var cancellables = Set<AnyCancellable>()
    var isLoading = CurrentValueSubject<Bool,Never>(false)
    @Published var isVallidLogIn:Bool = false
    @Published var isVallid:Bool = false
    @Published var emailText:String = ""
    @Published var nameText:String = ""
    @Published var passwordText:String = ""
    @Published var imageLinkUrl:String = ""
    @Published var errorText:String = ""
    @Published var showAlert = false
    
    private let mode:Mode
    init(userService:UserServicesProtocol = UserService(),mode:Mode) {
        self.userService = userService
        self.mode = mode
        Publishers.CombineLatest3($emailText,$passwordText,$nameText)
            .map{ [weak self] email,password,name in
                return self?.validateName(name) == true && self?.validateEmail(email) == true && self?.validatePassword(password) == true
            }
            .assign(to: &$isVallid)
        
        Publishers.CombineLatest($emailText,$passwordText)
            .map{ [weak self] email,password in
                return self?.validateEmail(email) == true && self?.validatePassword(password) == true
            }
            .assign(to: &$isVallidLogIn)
    }
    
    
    
    
    func tappedActionMode(){
        switch mode {
        case .signOut:
            try? Auth.auth().signOut()
            
        case .linkAnonmasyley:
            isLoading.value = true
            userService.linkAccountWithAnonmasyleyUser(email: emailText, password: passwordText, name: nameText)
                .sink { [weak self] (completion) in
                    guard let self = self else {return}
                    self.isLoading.value = false
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.showAlert = true
                        self.errorText = error.localizedDescription
                        print(error.localizedDescription)
                    }
                } receiveValue: {[weak self] (auth) in
                    guard let self = self else{return}
                    self.isLoading.value = false
                    print(auth?.email)
                }
                .store(in: &cancellables)

        
        case .signIn:
            isLoading.value = true
            userService.signInWithEmail(withEmail: emailText, password: passwordText)
                .sink { [weak self ](completion) in
                    guard let self = self else{return}
                    self.isLoading.value = false
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.showAlert = true
                        self.errorText = error.localizedDescription
                        print(error.localizedDescription)
                    }
                } receiveValue: { (authData) in
                    self.isLoading.value = false
                    print(authData.user.email)
                }
                .store(in: &cancellables)

        
        case .signUp:
            isLoading.value = true
            userService.createUser(withEmail: emailText, password: passwordText)
                .sink { (completion) in
                    self.isLoading.value = false
                    switch completion{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        self.showAlert = true
                        self.errorText = error.localizedDescription
                    }
                } receiveValue: { (authData) in
                    self.isLoading.value = false
                    print(authData.user.email ?? "")
                    
                    let userData = UserData(userId:Auth.auth().currentUser?.uid , userName: self.nameText, userEmail: self.emailText, userImageUrl: self.imageLinkUrl,createdAt: Date())
                    self.createUser(userData: userData).sink{ (result) in
                        switch result {
                        case .finished:
                            print("finished")
                        case .failure(let error):
                            self.showAlert = true
                            self.errorText = error.localizedDescription
                        }
                    } receiveValue: { (_) in
                        print("user inserted successfully")
                    }
                    .store(in: &self.cancellables)
                }
                .store(in:&cancellables)
          

                
            
            
        default:
            print("asdasd")
        }
    }
    
    
    private func createUser(userData:UserData)->AnyPublisher<Void, Error>{
        
        return userService.createUser(userData).eraseToAnyPublisher()
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
    
    func validatePassword(_ password:String)->Bool{
        return password.count > 5 && !password.isEmpty
    }
    func validateEmail(_ email:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: email)
    }
    
    func validateName(_ name:String)->Bool{
        return name.count > 5
    }
    
    enum Mode{
        case signIn
        case signUp
        case signOut
        case linkAnonmasyley
    }
}
