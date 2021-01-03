//
//  DragAndDropImage.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/03.
//

import Cocoa

class DragAndDropImage: NSObject, NSPasteboardWriting {
    
    var name: String!
    var nsURL: NSURL!
    
    init(name: String, nsURL: NSURL) {
        self.name = name
        self.nsURL = nsURL
    }
    
    // MARK: - NSPasteboardWriting
    
    func writingOptions(forType type: NSPasteboard.PasteboardType, pasteboard: NSPasteboard) -> NSPasteboard.WritingOptions {
        nsURL.writingOptions(forType: type, pasteboard: pasteboard)
    }
    
    func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        nsURL.writableTypes(for: pasteboard)
    }
    
    func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
        nsURL.pasteboardPropertyList(forType: type)
    }
}
