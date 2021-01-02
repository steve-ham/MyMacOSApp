//
//  ViewBasedTableVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/02.
//

import Cocoa

class ViewBasedTableVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    private let systemImages = ["pencil", "scribble", "highlighter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Open in Finder
        //NSWorkspace.shared.selectFile("filePath", inFileViewerRootedAtPath: nil)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        systemImages.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView else { return nil }
        
        
        cell.imageView?.image = NSImage(systemSymbolName: systemImages[row], accessibilityDescription: nil)
        cell.textField?.stringValue = systemImages[row]
        
        return cell
    }
}
