//
//  PondApp.swift
//  Pond
//
//  Created by HPro2 on 3/17/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAppCheck

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct PondApp: App {
    @StateObject var authViewModel = AuthViewModel()
//    let persistenceController = PersistenceController.shared
    
    init() {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
