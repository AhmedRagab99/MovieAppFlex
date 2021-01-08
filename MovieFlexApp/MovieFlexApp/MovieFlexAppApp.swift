//
//  MovieFlexAppApp.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/16/20.
//

import SwiftUI
import Firebase

@main
struct MovieFlexAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private  var appAuthState = AppState()
    @State var isLogIn = false
    var body: some Scene {
        WindowGroup {
            
            if appAuthState.isLoggedIn{
                SlideMenuView()
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

import Combine
final class AppState:ObservableObject{
    @Published private(set) var isLoggedIn = false
    private var cancel = Set<AnyCancellable>()
    
    private let userService:UserServicesProtocol
    
    init(userService:UserServicesProtocol = UserService()) {
        self.userService = userService
        
        userService
            .observeAuthStateChanges()
            .map{$0 != nil}
            .assign(to: &$isLoggedIn)
        
    }
}
