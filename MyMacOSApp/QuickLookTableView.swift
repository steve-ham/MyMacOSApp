//
//  QuickLookTableView.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

protocol QuickLookTableViewDelegate: NSObjectProtocol {
    func quickLookTableViewSpacebarPressed(_ quickLookTableView: QuickLookTableView)
}

class QuickLookTableView: NSTableView {
    
    weak var qltvDelegate: QuickLookTableViewDelegate?

    override func keyDown(with event: NSEvent) {
        if event.characters == "" {
            qltvDelegate?.quickLookTableViewSpacebarPressed(self)
        } else {
            super.keyDown(with: event)
        }
    }
    
}
