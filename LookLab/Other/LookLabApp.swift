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
    init() {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                FirebaseApp.configure()
            }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
