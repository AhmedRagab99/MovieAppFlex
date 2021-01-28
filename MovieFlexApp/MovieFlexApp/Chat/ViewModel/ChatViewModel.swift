//
//  ChatViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 28/01/2021.
//

import Combine
import FirebaseAuth

class ChatViewModel:ObservableObject{
    
    private let chatService:UserChatServicesProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userChats:[ChatModel] = []
    
    init(chatService:UserChatServicesProtocol = UserChatService()) {
        self.chatService = chatService
        let authId = Auth.auth().currentUser?.uid
        let chat = ChatModel(id: UUID().description, message: "test body", senderId: authId, reciverId: "Ah2zSxfnKzdehv9MFlcTQAOevQQ2", messageType: .text, timeStamp: Date())
        self.addChat(chat: chat, userId: authId ?? "" )
        self.observeChatChanges(userId: authId ?? "")
        
    }
    
    
    func addChat(chat:ChatModel,userId:String){
        self.chatService.addChatMessage(userId: userId, chat: chat).sink { (comp) in
            switch comp {
            case let .failure(error):
                print(error.localizedDescription)
            case .finished:
                print("added chat finished")
            }
        } receiveValue: { () in
            
            
            print("Added chat")
        }
        .store(in: &cancellables)
        
    }
    
    
    private func observeChatChanges(userId:String){
        
        self.chatService.observeChatDocuments(userId: userId).sink { (res) in
            switch res{
            case let .failure(error):
                print(error.localizedDescription)
            case .finished:
                print("Chat Finished")
            }
        } receiveValue: { (data) in
            self.userChats = data
            print(self.userChats)
        }
        .store(in: &cancellables)
        
    }
    
    
    
}
