//
//  SettingSection.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/19/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

// Protocol for Switch in Settings cells
protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

//  Sections listed in Settings tableView
enum SettingSection: Int, CaseIterable, CustomStringConvertible {
    case info
    case communications
    
    var description: String {
        switch self {
        case .info: return "Info"
        case .communications: return "Communications"
        }
    }
}
enum InfoOptions: Int, CaseIterable, SectionType {
    case profile
    case device
    
    var description: String {
        switch self {
        case .profile: return "Pet Profile"
        case .device: return "Device"
        }
    }
    var containsSwitch: Bool { return false}
}

enum CommunicationOptions: Int, CaseIterable, SectionType {
    case wifi
    case notification
    case email
    
    var description: String {
        switch self {
        case .wifi: return "Wi-Fi"
        case .notification: return "Notifications"
        case .email: return "Email"
        }
    }
    var containsSwitch: Bool {
        switch self {
        case .wifi: return false
        case .notification: return true
        case .email: return true
        }
    }
}

