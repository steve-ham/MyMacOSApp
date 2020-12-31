//
//  SplitViewController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func tapMenuItemFromSVC(_ menuItem: NSMenuItem) {
        // Need to make Auto Enable Items of Menu off
        NSApplication.shared.mainMenu?.items.forEach({ menuItem in
            if menuItem.title == "MyMenu" {
                menuItem.menu?.items.forEach({ menuItem2 in
                    if menuItem2.title == "Say Goodbye" {
                        menuItem2.isEnabled = false
                    }
                })
            }
        })
        
        
    }

}
