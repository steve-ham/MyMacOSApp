//
//  PrintVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

class PrintView: NSView {
    
    override var acceptsFirstResponder: Bool {
        true
    }
    
    override func printView(_ sender: Any?) {
        super.printView(sender)
        print("hsteve print")
        let operation = NSPrintOperation(view: self)
        operation.run()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if NSGraphicsContext.current?.isDrawingToScreen == true {
            NSColor.red.set()
            dirtyRect.fill()
        } else {
            NSColor.blue.set()
            dirtyRect.fill()
        }
    }
}

class PrintVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
}
