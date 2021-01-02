//
//  CustomButtonVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

class BlueButton: NSButton {
    
    override var wantsUpdateLayer: Bool {
        true
    }
    
    override func updateLayer() {
        print("hsteve updateLayer")
        layer?.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0, height: 0)
        if cell?.isHighlighted == true {
            layer?.contents = NSImage(named: "button_pressed")
        } else {
            layer?.contents = NSImage(named: "button")
        }
    }
}

class CustomButtonVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
