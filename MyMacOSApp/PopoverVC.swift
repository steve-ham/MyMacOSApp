//
//  PopoverVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/01.
//

import Cocoa

class PopoverVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func clickShowPopover(_ button: NSButton) {
        let vc = NSStoryboard(name: "Main", bundle: .main).instantiateController(withIdentifier: "Popover") as! NSViewController
        
        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = vc
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxX)
    }
}
