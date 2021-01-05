//
//  SystemIcon.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import AppKit

struct SystemIcon: Hashable {
    let name: String
    let userAdded: Bool
    let identifier = UUID()
    
    init(name: String, userAdded: Bool) {
        self.name = name
        self.userAdded = userAdded
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: SystemIcon, rhs: SystemIcon) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

