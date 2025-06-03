//
//  RegisterViewViewModel.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class RegisterViewViewModel : ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var anonRegisteredLocal: Bool = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("anonRegistered") var anonRegistered: Bool = false
    
    init() {}
    
    func register() {
        // Validate
        guard validate() else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)

        if let currentUser = Auth.auth().currentUser, currentUser.isAnonymous {
            // Case: User is currently anonymous -> link account
            currentUser.link(with: credential) { authResult, error in
                if let error = error as NSError? {
                    if let code = AuthErrorCode(rawValue: error.code) {
                        switch code {
                            case .emailAlreadyInUse:
                                self.error = "This email is already registered."
                            default:
                                self.error = error.localizedDescription
                        }
                    }
                    return
                }

                if let user = authResult?.user {
                    self.createUserIfNeeded(user: user) {
                        self.isLoggedIn = true
                        self.anonRegistered = true
                        self.anonRegisteredLocal = true
                    }
                }
            }
        } else {
            // Case: User is not signed in yet -> register normally
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error as NSError? {
                    if let code = AuthErrorCode(rawValue: error.code) {
                        switch code {
                            case .emailAlreadyInUse:
                                self.error = "This email is already registered."
                            default:
                                self.error = error.localizedDescription
                        }
                    }
                    return
                }
                
                if let user = authResult?.user {
                    self.createUserIfNeeded(user: user) {
                        self.isLoggedIn = true // this is the defintion of completion()
                    } // need trailing closure bc its async, therefore need to add a completion() in func
                }
            }
        }
    }
    
    
    private func createUserIfNeeded(user: FirebaseAuth.User, completion: @escaping () -> Void) { // escaping means running after the function returns, for async
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.getDocument { docSnapshot, error in
            if let doc = docSnapshot, doc.exists {
               completion()
            } else {
                let userData: [String: Any] = [
                    "id": user.uid,
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "email": self.email,
                    "isAnonymous": user.isAnonymous,
                    "createdAt": Timestamp(date: Date())
                ]
                
                userRef.setData(userData, merge: true) { err in
                    if err == nil {
                        completion()
                    } else {
                        self.error = "Failed to save user data."
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
