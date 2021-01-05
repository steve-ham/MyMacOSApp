//
//  ViewController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet private weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let o = representedObject as? String ?? ""
        label.stringValue = representedObject as? String ?? ""
    }
    
    
}
