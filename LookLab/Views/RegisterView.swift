//
//  RegisterView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false // bruh appstorage doesn't update if in separate views or sum shi
    @AppStorage("anonRegistered") var anonRegistered: Bool = false // TODO: put this to use somehow in the future bc rn working w text and it sucks
    
    var body: some View {
        ZStack {
            Color(hex: "#373539")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Sign Up")
                    .font(.system(size: 60, weight: .bold))
                    .padding(.top, 100)
                    .padding(.bottom, 50)
                    .foregroundColor(Color(hex: "#FCA8E1"))
                
                VStack(spacing: 16) {
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .foregroundColor(.red)
                    }
                    
                    TextField("First Name", text: $viewModel.firstName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    TextField("Last Name", text: $viewModel.lastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)

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
                
                if viewModel.anonRegisteredLocal {
                    Text("Your account has been registered. Click the back button to resume your experience.")
                        .foregroundColor(.white)
                }
                
                NavigationStack {
                    Button (action: {
                        viewModel.register()
                    }) {
                        Text("Sign Up")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "#FCA8E1"))
                                .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
