//
//  PresentationAnimatorVC2.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class PresentationAnimatorVC2: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.yellow.cgColor
    }
    
    @IBAction private func clickDismissButton(_ sender: NSButton) {
        dismiss(self)
    }
}
