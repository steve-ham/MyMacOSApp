//
//  CoreDataViewController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/31.
//

import Cocoa

class CoreDataViewController: NSViewController {
    
    @objc let managedObjectContext = (NSApp.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func tapUndoButton(_ sender: NSButton) {
        managedObjectContext.undo()
    }
}
