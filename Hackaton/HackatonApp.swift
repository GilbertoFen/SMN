//
//  HackatonApp.swift
//  Hackaton
//
//  Created by Annete Morado on 23/03/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct HackatonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                tabviewOnboarding(authViewModel: authViewModel)
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}
