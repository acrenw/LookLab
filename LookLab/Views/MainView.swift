//
//  ContentView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("anonRegistered") var anonRegistered: Bool = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(hex: "#6F627B"))
        if anonRegistered {
            anonRegistered = false
        }
    }
    
    var body: some View {
        NavigationStack() {
            TabView {
                DesignView()
                    .tabItem {
                        Label("Design", systemImage: "pencil.and.scribble")
                    }
                WardrobeView()
                    .tabItem {
                        Label("Wardrobe", systemImage: "hanger")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
            .tint(Color(hex: "#FCA8E1"))
        }
    }
}

#Preview {
    MainView()
}
