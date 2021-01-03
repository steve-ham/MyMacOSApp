//
//  Food.swift
//  NSTableDiffableSampleCode
//
//  Created by steve.ham on 2021/01/04.
//

import Foundation

struct Food: Hashable {
    let identifier = UUID()
    let name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
