//
//  WindowControllerVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class WindowControllerVC: NSViewController {
    
    @IBAction private func showWindowController1(_ sender: NSButton) {
        let windowController1 = WindowController1()
        windowController1.showWindow(nil)
    }
    
    @IBAction private func showWindowController2(_ sender: NSButton) {
        let windowController2 = WindowController2()
        windowController2.showWindow(nil)
    }
    
}
