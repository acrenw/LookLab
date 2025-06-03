//
//  LookLabApp.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI
import FirebaseCore

@main
struct LookLabApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("anonRegistered") var anonRegistered = false
    
    init() {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                FirebaseApp.configure()
            }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn || anonRegistered {
                    MainView()
                } else {
                    LoginView()
                }
            }
            .id(isLoggedIn || anonRegistered) // <- forces full refresh when isLoggedIn changes
        }
    }
}
