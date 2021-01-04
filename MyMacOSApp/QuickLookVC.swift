//
//  QuickLookVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class QuickLookVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: "/Users/steve")
        } catch let error {
            
            print("hsteve error.localizedDescription \(error.localizedDescription)")
        }
        
//        print("hsteve paths \(paths)")
    }
    
}
