//
//  MovieFlexAppApp.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/16/20.
//

import SwiftUI

@main
struct MovieFlexAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SlideMenuView()
        }
    }
}


class AppDelegate:NSObject,UIApplicationDelegate{
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
}
