//
//  CircleView.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class CircleView: NSView {

    override var wantsUpdateLayer: Bool {
        true
    }
    
    override func updateLayer() {
        layer?.backgroundColor = NSColor.white.cgColor
        layer?.cornerRadius = frame.width / 2.0
    }
    
}
