//
//  ImageViewVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class ImageViewVC: NSViewController {

    @IBOutlet private weak var imageView: NSImageView! {
        didSet {
            imageView.image = NSImage(named: "earth")
        }
    }
}
