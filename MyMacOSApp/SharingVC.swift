//
//  SharingVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/01.
//

import Cocoa

class SharingVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func clickShareButton(_ sender: NSButton) {
        guard let image = NSImage(named: "earth") else { return }
        let picker = NSSharingServicePicker(items: [image])
        picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
    }
}
