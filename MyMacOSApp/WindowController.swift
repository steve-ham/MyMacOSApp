//
//  WindowController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction private func tapMenuItemFromWC(_ menuItem: NSMenuItem) {
        if let svc = contentViewController as? NSSplitViewController {
            if let vc = svc.children[1] as? MenuVC {
                vc.tapMenuItemFromWC()
            }
        }
    }
}
