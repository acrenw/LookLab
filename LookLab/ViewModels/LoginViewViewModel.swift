//
//  LoginViewViewModel.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class LoginViewViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    init() {}
    
    func login() {
        // Validate
        guard validate() else {
            return
        }
        
        // Try login
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                print("Firebase error code: \(error.code)")
                print("NSError:", error)
                
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        self.error = "No user found with this email."
                    case .wrongPassword:
                        self.error = "Incorrect password."
                    case .invalidEmail:
                        self.error = "Invalid email address."
                    case .networkError:
                        self.error = "Network error. Try again."
                    default:
                        self.error = error.localizedDescription
                    }
                } else {
                    self.error = error.localizedDescription
                }
                print("Login failed:", self.error)
                return
            }
            
            // Login successful
            print("Logged in successfully with UID:", result?.user.uid ?? "")
            self.isLoggedIn = true
        }
    }
        
    func signInAnonymously() {
        Auth.auth().signInAnonymously { result, error in
            guard let user = result?.user else { return }
            self.createUserIfNeeded(user: user) {
                self.isLoggedIn = true
            }
        }
    }
    
    private func createUserIfNeeded(user: FirebaseAuth.User, completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.getDocument { docSnapshot, error in
            if let doc = docSnapshot, doc.exists {
                // User doc already exists
                completion()
            } else {
                // Create new user doc
                let userData: [String: Any] = [
                    "id": user.uid,
                    "isAnonymous": user.isAnonymous,
                    "createdAt": Timestamp(date: Date())
                ]
                
                userRef.setData(userData) { err in
                    if let err = err {
                        print("Error creating user document:", err.localizedDescription)
                    } else {
                        print("Anonymous user document created in Firestore")
                        completion()
                    }
                }
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
