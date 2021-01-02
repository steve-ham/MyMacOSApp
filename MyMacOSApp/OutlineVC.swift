//
//  OutlineVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

class OutlineVC: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
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
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let cell = outlineView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if tableColumn!.identifier.rawValue == "Name" {
            if let person = item as? Person {
                cell.textField?.stringValue = person.name
            }
        } else if tableColumn!.identifier.rawValue == "Age" {
            if let person = item as? Person {
                cell.textField?.stringValue = "\(person.age)"
            }
        }
        
        return cell
        
//        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
    }
}
