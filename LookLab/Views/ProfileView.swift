//
//  ProfileView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var selectedPage: ProfilePageEnum? = nil
    @State private var showLogoutAlert: Bool = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#373539")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "#FFE591"), Color(hex: "#FF99E5"), Color(hex: "#AD47FF")],
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing
                                    )
                                )
                                .frame(
                                    maxWidth: UIScreen.main.bounds.width / 2,
                                    maxHeight: .infinity
                                )
                            VStack {
                                // TODO: change
                                Text("🧍‍♀️")
                                    .font(.system(size: 120))
                                Text("Upload")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        
                        VStack {
                            // TODO: get data from db
                            // TODO: make units convertible
                            InfoBoxView(text: "Height", data: "167 cm")
                            InfoBoxView(text: "Weight", data: "103 kg")
                            InfoBoxView(text: "Bust", data: "70 cm")
                            InfoBoxView(text: "Waist", data: "40 cm")
                            
                            Button (action: {
                                // TODO: edit profile
                            }) {
                                Text("Edit Profile")
                                    .foregroundColor(Color(hex: "#FF99E5"))
                                    .bold()
                            }
                            .padding(.top, 40)
                        }
                        .alignmentGuide(.top) { d in d[.top] }
                    }
                    .padding()
                    .padding(.bottom, 100)
                    .alignmentGuide(.top) { d in d[.top] }
                    
                    Spacer()
                    
                    VStack {
                        ClickableInfoBoxView(text: "Default Models", onBoxPressed: {
                            selectedPage = .defaultModels
                        })
                        ClickableInfoBoxView(text: "Settings", onBoxPressed: {
                            selectedPage = .settings
                        })
                        ClickableInfoBoxView(text: "Notifications", onBoxPressed: {
                            selectedPage = .notifications
                        })
                        ClickableInfoBoxView(text: "Privacy", onBoxPressed: {
                            selectedPage = .privacy
                        })
                        
                        Spacer()
                        
                        if viewModel.user?.isAnonymous ?? false
                        {
                            Button(action: {
                                viewModel.goToRegister = true
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(Color(hex: "#FF99E5"))
                                    .bold()
                            }
                            .padding(.horizontal)
                        }
                        
                        Button(action: {
                            if viewModel.user?.isAnonymous ?? false {
                                showLogoutAlert = true
                            } else {
                                viewModel.logout()
                            }
                        }) {
                            Text("Log Out")
                                .foregroundColor(.red)
                                .bold()
                        }
                        .padding()
                        .alert("Log out?", isPresented: $showLogoutAlert) {
                            Button("Log Out", role: .destructive) {
                                viewModel.logout()
                            }
                            Button("Sign Up", role: .none) {
                                viewModel.goToRegister = true
                            }
                            Button("Cancel", role: .cancel) {}
                            // TODO: make colour visible
                        } message: {
                            Text("You’re currently signed in anonymously. If you log out, your data will be lost. Sign up to keep your data.")
                        }
                    }
                    .padding()
                    .navigationDestination(item: $selectedPage) { page in
                        switch page {
                        case .defaultModels:
                            DefaultModelsView()
                        case .settings:
                            SettingsView()
                        case .notifications:
                            NotificationsView()
                        case .privacy:
                            PrivacyView()
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.goToRegister) {
                        RegisterView()
                    }

                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
