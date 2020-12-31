//
//  KeyboardEventsVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/31.
//

import Cocoa

class KeyboardEventsView: NSView {
    
    @IBOutlet private weak var label: NSTextField!
    
    override var acceptsFirstResponder: Bool {
        true
    }
    
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        label.stringValue = event.characters ?? ""
    }
}

class KeyboardEventsVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
