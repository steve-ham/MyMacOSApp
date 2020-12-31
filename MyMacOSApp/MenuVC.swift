//
//  MenuVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class MenuVC: NSViewController {
    
    @IBOutlet private weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func tapMenuItemFromWC() {
        label.stringValue = "Hello"
    }
}
