//
//  LoginView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

// TODO: signing up after anonymous doesn't update firebasedb records, but updates auth
// TODO: anon -> (logout) -> sign up -> fill in sign up form -> click sign up button on sign up form -> nothing happens -> click back button -> lands on MainView that's logged in with the account we just registered

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @State private var showRegisterView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#373539")
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Text("Sign In")
                        .font(.system(size: 60, weight: .bold))
                        .padding(.top, 100)
                        .padding(.bottom, 50)
                        .foregroundColor(Color(hex: "#FCA8E1"))
                    
                    VStack(spacing: 16) {
                        if !viewModel.error.isEmpty {
                            Text(viewModel.error)
                                .foregroundColor(.red)
                        }
                        
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        SecureField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    Button (action: {
                        viewModel.login()
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#FCA8E1"))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Button (action: {
                        viewModel.signInAnonymously()
                    }) {
                        Text("Continue anonymously")
                            .foregroundColor(Color(hex: "#FCA8E1"))
                            .bold()
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button (action: {
                        showRegisterView = true
                    }) {
                        Text("Sign Up")
                            .foregroundColor(Color(hex: "#FCA8E1"))
                            .bold()
                            .padding()
                            .padding(.bottom, 40)
                    }
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $showRegisterView) {
                RegisterView()
            }
        }
    }
}

#Preview {
    LoginView()
}
