//
//  AlertVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/01.
//

import Cocoa

class AlertVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func clickShowAlertButton(_ sender: NSButton) {
        let alert = NSAlert()
        alert.messageText = "Hello world"
        alert.informativeText = "Information text"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        //alert.runModal() // Alert
        if let window = view.window {
            alert.beginSheetModal(for: window) { response in // Alert Sheet
                if response == .alertFirstButtonReturn {
                    print("hsteve 1")
                } else if response == .alertSecondButtonReturn {
                    print("hsteve 2")
                }
            }
        }
    }
}
