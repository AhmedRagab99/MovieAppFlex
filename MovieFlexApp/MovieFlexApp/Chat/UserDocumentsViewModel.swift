//
//  UserDocumentsViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 19/01/2021.
//

import Combine
import FirebaseAuth

final class UserChatViewModel:ObservableObject{
    
    private let userServices:AuthServiceProtocol
    private let userChatService:UserChatServicesProtocol
    private var cancellables:[AnyCancellable] = []
    
    
    @Published var userData :[UserData] = []
    init( userServices:AuthServiceProtocol = AuthService(),userChatService:UserChatServicesProtocol = UserChatService()) {
        self.userServices = userServices
        self.userChatService = userChatService
        self.observeChanges()
    }
    
    private func observeChanges(){
        userServices.currentUser().compactMap{$0?.uid}
            .flatMap{userId ->AnyPublisher<[UserData],MovieAppFlexError> in
                return self.userChatService.observerUserDocumnets(userId: userId)
            }.sink { (completion) in
                switch completion{
                case .finished:
                    print("Finished")
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { (data) in
                print(data)
                self.userData = data
            }
            .store(in: &cancellables)
    }
    
}



