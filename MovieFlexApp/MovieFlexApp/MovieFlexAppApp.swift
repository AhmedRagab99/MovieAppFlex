//
//  MovieFlexAppApp.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/16/20.
//

import SwiftUI
import Firebase
import Combine
@main
struct MovieFlexAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private  var appAuthState = AppState()
    @StateObject private var userChatViewModel = UserChatViewModel()
    
    @State var isLogIn = false
    var body: some Scene {
        WindowGroup {
            if appAuthState.isLoggedIn{
                SlideMenuView(userChatViewModel: userChatViewModel)
                    .environmentObject(FavouriteMovieEnviroment())
                    .environmentObject(UserDocumentEnviroment())
                    
                    
            } else {
                SignInView()
                    

            }
        }
        
    }
}




class AppDelegate:NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}





final class AppState:ObservableObject{
    @Published private(set) var isLoggedIn = false
    private var cancel = Set<AnyCancellable>()
    
    private let userService:AuthServiceProtocol
    
    init(userService:AuthServiceProtocol = AuthService()) {
        self.userService = userService
        
        userService
            .observeAuthStateChanges()
            .map{$0 != nil}
            .assign(to: &$isLoggedIn)
        
    }
}
