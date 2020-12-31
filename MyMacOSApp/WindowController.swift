//
//  WindowController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.delegate = self
    }
    
    @IBAction private func tapMenuItemFromWC(_ menuItem: NSMenuItem) {
        if let svc = contentViewController as? NSSplitViewController {
            if let vc = svc.children[1] as? MenuVC {
                vc.tapMenuItemFromWC()
            }
        }
    }
    
    func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
        return (NSApp.delegate as! AppDelegate).persistentContainer.viewContext.undoManager
    }
}
