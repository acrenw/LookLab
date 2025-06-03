//
//  ProfilePageEnum.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import Foundation


enum ProfilePageEnum: String, Identifiable {
    case defaultModels = "Default Models"
    case settings = "Settings"
    case notifications = "Notifications"
    case privacy = "Privacy"
    
    var id: String { rawValue }
}
