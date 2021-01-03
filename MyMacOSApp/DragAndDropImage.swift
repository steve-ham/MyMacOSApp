//
//  DragAndDropImage.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/03.
//

import Cocoa

class DragAndDropImage: NSObject, NSPasteboardWriting, NSPasteboardReading {
    
    var name: String!
    var nsURL: NSURL!
    
    init(name: String, nsURL: NSURL) {
        super.init()
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
    
    // MARK: - NSPasteboardReading
    
    static func readableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        [.fileURL]
    }
    
    static func readingOptions(forType type: NSPasteboard.PasteboardType, pasteboard: NSPasteboard) -> NSPasteboard.ReadingOptions {
        .asString
    }
    
    required init?(pasteboardPropertyList propertyList: Any, ofType type: NSPasteboard.PasteboardType) {
        super.init()
        nsURL = NSURL(pasteboardPropertyList: propertyList, ofType: type)
        name = (try? nsURL.absoluteURL?.resourceValues(forKeys: [.localizedNameKey]).localizedName) ?? ""
        if let _ = NSImage(contentsOf: nsURL as URL) {
        } else {
            return nil
        }
//        DragAndDropImage
    }
}
