//
//  CustomSheetVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/01.
//

import Cocoa

class CustomSheetVC: NSViewController {
    
    private lazy var sheetWindow: NSWindow = {
        let wc = NSStoryboard(name: "Main", bundle: .main).instantiateController(withIdentifier: "SheetWindowController") as! NSWindowController
        return wc.window!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func clickShowCustomSheetButton(_ sender: NSButton) {
        view.window?.beginSheet(sheetWindow) { response in
            print("hsteve response \(response)")
        }
    }
}
