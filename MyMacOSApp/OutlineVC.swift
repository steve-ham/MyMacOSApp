//
//  OutlineVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

class OutlineVC: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    @IBOutlet private weak var outlineView: NSOutlineView!
    
    private lazy var people: [Person] = {
        var people = [Person]()
        var yoda = Person(name: "Yoda", age: 900, children: [Person]())
        var stephan = Person(name: "Stephan", age: 20, children: [Person]())
        let taylor = Person(name: "Taylor", age: 18, children: [Person]())
        let jesse = Person(name: "Jesse", age: 19, children: [Person]())
        let lucas = Person(name: "Lucas", age: 18, children: [Person]())
        
        yoda.children.append(stephan)
        yoda.children.append(taylor)
        yoda.children.append(jesse)
        stephan.children.append(lucas)
        people.append(yoda)
        return people
    }()
    
    // MARK: - NSOutlineViewDataSource
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return people.count
        } else {
            return (item as? Person)?.children.count ?? 0
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        ((item as? Person)?.children.count ?? 0) > 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return people[index]
        } else {
            return (item as? Person)?.children[index] ?? (item as? Person)!
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        if tableColumn?.identifier.rawValue == "Name" {
            if let person = item as? Person {
                return person.name
            }
        } else {
            if let person = item as? Person {
                return person.age
            }
        }
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, byItem item: Any?) {
        if tableColumn?.identifier.rawValue == "Name" {
            if let person = item as? Person {
                person.name = object as? String ?? ""
            }
        } else {
            if let person = item as? Person {
                let age = Int(object as? String ?? "") ?? 0
                return person.age = age
            }
        }
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        let person = outlineView.item(atRow: outlineView.selectedRow) as? Person
        
        if person == nil {
            let p = Person(name: "Unnamed", age: 0, children: [Person]())
            people.append(p)
        } else {
            let p = Person(name: "Unnamed", age: 0, children: [Person]())
            person?.children.append(p)
        }
        outlineView.reloadData()
    }
    
    @IBAction private func clickRemoveButton(_ sender: NSButton) {
        let child = outlineView.item(atRow: outlineView.selectedRow) as? Person
        let parent = outlineView.parent(forItem: child) as? Person
        if let parent = parent, let child = child {
            if let index = parent.children.firstIndex(where: { $0 === child }) {
                parent.children.remove(at: index)
            }
        } else {
            people.removeAll()
        }
        outlineView.reloadData()
    }
    
    
}
