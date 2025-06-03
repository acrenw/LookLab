//
//  ProfileViewViewModel.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation
import SwiftUI

class ProfileViewViewModel : ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var goToRegister: Bool = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("User signed out successfully")
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
