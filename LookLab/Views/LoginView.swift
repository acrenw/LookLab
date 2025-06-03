//
//  LoginView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        ZStack {
            Color(hex: "#373539")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Login")
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
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                Button (action: {
                    viewModel.signInAnonymously()
                }) {
                    Text("Continue anonymously")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#FCA8E1"))
                            .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Sign Up")
                        .foregroundColor(Color(hex: "#FCA8E1"))
                        .fontWeight(.bold)
                        .padding()
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
