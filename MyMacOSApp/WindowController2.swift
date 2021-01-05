//
//  WindowController2.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class WindowController2: NSWindowController {
    
    convenience init() {
        self.init(windowNibName: "")
    }

    override func loadWindow() {
        self.window = Window(contentRect: NSMakeRect(100, 100, 400, 300), styleMask: [], backing: .buffered, defer: true)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        let vc = ViewController()
        vc.representedObject = "From WindowController2"
        contentViewController = vc
    }

}
