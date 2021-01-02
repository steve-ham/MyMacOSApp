//
//  ViewBasedTableVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

enum Row {
    case section(String)
    case row(String)
}

class ViewBasedTableVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet private weak var tableView: NSTableView!
    
    private var systemRows: [Row] = {
        var rows = [Row.section("Draw"), Row.row("pencil"), Row.row("scribble"), Row.section("Highlight"), Row.row("highlighter")]
        let moreRows = ["square.and.arrow.up", "square.and.arrow.up.fill", "square.and.arrow.down", "square.and.arrow.down.fill", "pencil.circle", "pencil.circle.fill", "pencil.slash", "square.and.pencil"].map(Row.row)
        rows.append(contentsOf: moreRows)
        return rows
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open in Finder
        //NSWorkspace.shared.selectFile("filePath", inFileViewerRootedAtPath: nil)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        systemRows.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if case .section(let title) = systemRows[row] {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GroupCell"), owner: self) as? NSTextField {
                cell.stringValue = title
                return cell
            }
        } else if case .row(let title) = systemRows[row] {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView {
                cell.imageView?.image = NSImage(systemSymbolName: title, accessibilityDescription: nil)
                cell.textField?.stringValue = title
                return cell
            }
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
        if case .section = systemRows[row] {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if case .section = systemRows[row] {
            return 22
        } else {
            return 50
        }
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        systemRows.insert(Row.row("pencil"), at: tableView.selectedRow)
        tableView.beginUpdates()
        tableView.insertRows(at: IndexSet(integer: tableView.selectedRow), withAnimation: .slideDown)
        tableView.scrollRowToVisible(tableView.selectedRow)
        tableView.endUpdates()
    }
    
    @IBAction private func clickRemoveButton(_ sender: NSButton) {
        tableView.selectedRowIndexes.forEach { index in
            systemRows.remove(at: index)
        }
        tableView.removeRows(at: tableView.selectedRowIndexes, withAnimation: .slideDown)
    }
    
}
