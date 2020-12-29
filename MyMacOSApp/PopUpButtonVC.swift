//
//  PopUpButtonVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class PopUpButtonVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func selectPopUpButton(_ sender: NSPopUpButton) {
        print("hsteve sender.indexOfSelectedItem \(sender.indexOfSelectedItem)")
    }
}
