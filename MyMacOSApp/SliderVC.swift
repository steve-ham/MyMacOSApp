//
//  SliderVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class SliderVC: NSViewController {
    @IBOutlet private weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func slideSlider(_ sender: NSSlider) {
        label.stringValue = sender.stringValue
    }
}
