//
//  DatePickerVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/30.
//

import Cocoa

class DatePickerVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func clickDatePicker(_ sender: NSDatePicker) {
        print("hsteve clickDatePicker \(sender.dateValue)")
    }
}
