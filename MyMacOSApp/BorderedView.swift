//
//  BorderedView.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class BorderedView: NSView {
    
    @IBInspectable var backgroundColor: NSColor? {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable var borderColor: NSColor? {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { needsDisplay = true }
    }
    
    override func animation(forKey key: NSAnimatablePropertyKey) -> Any? {
        key == "borderWidth" ? CABasicAnimation() : super.animation(forKey: key)
    }
    
    override var wantsUpdateLayer: Bool {
        true
    }
    
    override func updateLayer() {
        guard let layer = layer else { return }
        layer.backgroundColor = backgroundColor?.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
    }
}
