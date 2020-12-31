//
//  MouseEventsVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/31.
//

import Cocoa

class MouseEventsView: NSView {
    
    private var startPoint = NSPoint(x: 0, y: 0)
    private var endPoint = NSPoint(x: 0, y: 0)
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.red.set()
        dirtyRect.fill()
        NSColor.blue.set()
        let rect = NSRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
        NSBezierPath(rect: rect).fill()
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let windowWidth = window?.frame.width else { return }
        let differenceWidth = windowWidth - bounds.width
        let point = NSPoint(x: event.locationInWindow.x - (differenceWidth * 2), y: event.locationInWindow.y)
        startPoint = convert(point, to: nil)
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let windowWidth = window?.frame.width else { return }
        let differenceWidth = windowWidth - bounds.width
        let point = NSPoint(x: event.locationInWindow.x - (differenceWidth * 2), y: event.locationInWindow.y)
        endPoint = convert(point, to: nil)
        setNeedsDisplay(bounds)
    }
}

class MouseEventsVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
