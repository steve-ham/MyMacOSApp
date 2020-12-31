//
//  ListViewController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/19.
//

import Cocoa

class ListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    private var subjects = ["TableViewVC", "DatePickerVC", "SliderVC", "PopUpButtonVC", "ImageViewVC", "MenuVC", "DragAndDropVC", "MouseEventsVC", "KeyboardEventsVC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let v = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        v.textField?.stringValue = subjects[row]
        
        return v
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let splitViewController = parent as? NSSplitViewController, let tableView = notification.object as? NSTableView else { return }
        
        print("hsteve tableView.selectedRow \(tableView.selectedRow)")
        let subject = subjects[tableView.selectedRow]
        
        let storyboard = NSStoryboard(name: "Main", bundle: Bundle.main)
        let c = storyboard.instantiateController(withIdentifier: subject)
        
        if let vc = c as? TableViewVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? DatePickerVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? SliderVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? PopUpButtonVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? ImageViewVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? MenuVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? DragAndDropVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? MouseEventsVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? KeyboardEventsVC {
            splitViewController.children[1] = vc
        }
    }
}
