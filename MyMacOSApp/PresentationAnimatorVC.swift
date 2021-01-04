//
//  PresentationAnimatorVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class PresentationAnimatorVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func clickPresentButton(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        if let vc = storyboard.instantiateController(withIdentifier: "PresentationAnimatorVC2") as? PresentationAnimatorVC2 {
            present(vc, animator: ModalPresentationAnimator())
        }
    }
}
