//
//  TableViewVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/19.
//

import Cocoa

class TableViewVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet private weak var textField: NSTextField!
    @IBOutlet private weak var tableView: NSTableView!
    
    private var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction private func tapAddButton(_ sender: NSButton) {
        titles.append(textField.stringValue)
        tableView.reloadData()
        textField.stringValue = ""
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        titles.count
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if tableColumn?.title == "Index" {
            vw.textField?.stringValue = "\(row)"
        } else {
            vw.textField?.stringValue = titles[row]
        }
        return vw
    }
}
