//
//  AutoLayoutVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class AutoLayoutVC: NSViewController {
    @IBOutlet private weak var customView: NSView! {
        didSet {
            customView.wantsLayer = true
            customView.layer?.backgroundColor = NSColor.blue.cgColor
            customView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([customView.topAnchor.constraint(equalTo: view.topAnchor),
                                         customView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                         customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                         customView.leftAnchor.constraint(equalTo: view.leftAnchor)])
        }
    }
}
