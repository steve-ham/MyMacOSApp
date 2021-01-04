//
//  DrawingView.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class DrawingView: NSView {

    override func mouseDown(with theEvent: NSEvent) {
        let point = convert(theEvent.locationInWindow, from: nil)
        if theEvent.modifierFlags.contains(.option) {
            if let view = hitTest(point), view is CircleView {
                removeCircle(view)
                undoManager?.setActionName("Remove Circle")
            }
        } else {
            let circle = CircleView(frame: NSMakeRect(point.x - 15, point.y - 15, 30, 30))
            addCircle(circle)
            undoManager?.setActionName("Add Circle")
        }
    }
    
    @objc func addCircle(_ circle: NSView) {
        addSubview(circle)
        undoManager?.registerUndo(withTarget: self, selector: #selector(removeCircle(_:)), object: circle)
    }
    
    @objc func removeCircle(_ circle: NSView) {
        circle.removeFromSuperview()
        undoManager?.registerUndo(withTarget: self, selector: #selector(addCircle(_:)), object: circle)
    }

    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        layer?.backgroundColor = NSColor.black.cgColor
    }
    
}
