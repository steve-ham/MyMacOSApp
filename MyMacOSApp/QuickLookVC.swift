//
//  QuickLookVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa
import Quartz

// Need to press "x" of App Sandbox

class QuickLookVC: NSViewController, QuickLookTableViewDelegate, NSTableViewDataSource, NSTableViewDelegate, QLPreviewPanelDataSource, QLPreviewPanelDelegate {
    
    @IBOutlet private weak var tableView: QuickLookTableView! {
        didSet {
            tableView.qltvDelegate = self
        }
    }
    private lazy var files: [URL] = {
        try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/Users/steve"), includingPropertiesForKeys: [.volumeURLKey], options: .skipsHiddenFiles)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("hsteve paths \(paths)")
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        files.count
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = files[row].absoluteString
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard notification.object as? NSObject == tableView else { return }
        guard let panel = QLPreviewPanel.shared() else { return }
        if QLPreviewPanel.sharedPreviewPanelExists(), panel.isVisible {
            panel.reloadData()
        }
    }
    
    // MARK: - QuickLookTableViewDelegate
    
    func quickLookTableViewSpacebarPressed(_ quickLookTableView: QuickLookTableView) {
        guard let panel = QLPreviewPanel.shared() else { return }
        if QLPreviewPanel.sharedPreviewPanelExists(), panel.isVisible {
            panel.orderOut(nil)
        } else {
            panel.makeKeyAndOrderFront(nil)
            panel.reloadData()
        }
    }
    
    // MARK: - QLPreviewPanelDataSource
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        tableView.selectedRowIndexes.count
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        var selectedFiles = [URL]()
        for i in tableView.selectedRowIndexes {
            selectedFiles.append(files[i])
        }
        return selectedFiles[index] as NSURL
    }
    
    // MARK: - QLPreviewPanelDelegate
    
    func previewPanel(_ panel: QLPreviewPanel!, handle event: NSEvent!) -> Bool {
        if event.type == .keyDown {
            tableView.keyDown(with: event)
            return true
        }
        return false
    }
    
    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        true
    }
    
    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = self
        panel.delegate = self
    }
    
    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = nil
        panel.delegate = nil
    }
}
