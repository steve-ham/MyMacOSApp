//
//  DragAndDropVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/31.
//

import Cocoa

class DragAndDropImageView: NSImageView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        registerForDraggedTypes([.URL])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        print("hsteve draggingEntered")
        return .copy
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        print("hsteve draggingUpdated")
        return .copy
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        print("hsteve draggingEnded")
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        print("hsteve draggingExited")
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let image = NSImage(pasteboard: sender.draggingPasteboard) else { return false }
        
        self.image = image
        return true
    }
}

class DragAndDropVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
