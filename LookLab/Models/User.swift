//
//  User.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import FirebaseFirestore
import Foundation

struct User: Identifiable, Codable {
    var id: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var profileImageUrl: String?
    var isPremium: Bool
    var isAnonymous: Bool
    var createdAt: TimeInterval
    var currentAvatarId: String?
//    var preferences: UserPreferences?    // UI or filter preferences
}
