//
//  MainViewViewModel.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseAuth
import Foundation

class MainViewViewModel : ObservableObject {
    @Published var currentUserId: String = "" // use outside
    private var handler: AuthStateDidChangeListenerHandle? // need handler to listen for auth changes to assigned currentUserId
    
    init() {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
            self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
                    self?.currentUserId = user?.uid ?? ""
                }
            }
        }
    }
    
    // variable not function!
    public var isSignedIn: Bool {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return false
        }
        
        return Auth.auth().currentUser != nil
    }
}
