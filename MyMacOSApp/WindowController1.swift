//
//  WindowController1.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class WindowController1: NSWindowController {
    
    convenience init() {
        self.init(windowNibName: "WindowController1")
    }
    
    //    override var windowNibName: NSNib.Name? {
    //        "WindowController1"
    //    }

    override func windowDidLoad() {
        super.windowDidLoad()
        let vc = ViewController()
        vc.representedObject = "From WindowController1"
        contentViewController = vc
    }
    
}
