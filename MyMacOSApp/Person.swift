//
//  Person.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Foundation

class Person {
    var name: String
    var age: Int
    var children: [Person]
    
    init(name: String, age: Int, children: [Person]) {
        self.name = name
        self.age = age
        self.children = children
    }
}
