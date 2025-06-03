//
//  LoginViewViewModel.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseAuth
import Foundation

class LoginViewViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    
    init() {}
    
    func login() {
        // Validate
        guard validate() else {
            return
        }
        
        // Try login
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { result, error in
           if let error = error {
               print("Anonymous sign-in failed:", error.localizedDescription)
           } else {
               print("Signed in anonymously with UID:", result?.user.uid ?? "")
           }
        }
    }
    
    private func validate() -> Bool {
        error = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            error = "Please enter valid email."
            return false
        }
        
        return true
    }
}
