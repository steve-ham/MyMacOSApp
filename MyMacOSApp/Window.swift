//
//  Window.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class Window: NSWindow {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.fullSizeContentView], backing: .buffered, defer: true)
        isMovableByWindowBackground = true
        backgroundColor = NSColor.systemGray
    }
    
}
