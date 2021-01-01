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
        //tableView.sortDescriptors = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        titles.append(textField.stringValue)
        tableView.reloadData()
        textField.stringValue = ""
    }
    
    @IBAction private func clickRemoveButton(_ sender: NSButton) {
        guard !titles.isEmpty else { return }
        titles.removeLast()
        tableView.reloadData()
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        titles.count
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if tableColumn!.identifier.rawValue == "Index" {
            vw.textField?.stringValue = "\(row)"
        } else {
            vw.textField?.stringValue = titles[row]
        }
        return vw
    }
}
