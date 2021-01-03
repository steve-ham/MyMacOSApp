//
//  DragAndDropTableVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/03.
//

import Cocoa

class DragAndDropTableVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet private weak var tableView: NSTableView! {
        didSet {
            tableView.setDraggingSourceOperationMask(.every, forLocal: false)
        }
    }
    private var dragAndDropImages = [DragAndDropImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        dragAndDropImages.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        cell.imageView?.image = NSImage(contentsOf: dragAndDropImages[row].nsURL as URL)
        cell.textField?.stringValue = dragAndDropImages[row].name
        return cell
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        dragAndDropImages[row]
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.allowedFileTypes = NSImage.imageTypes
        openPanel.begin { [weak self] response in
            guard let self = self else { return }
            if response == .OK {
                self.dragAndDropImages = openPanel.urls.map { url -> DragAndDropImage in
                    let name = (try? url.resourceValues(forKeys: [.localizedNameKey]).localizedName) ?? ""
                    return DragAndDropImage(name: name, nsURL: url as NSURL)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction private func clickRemoveButton(_ sender: NSButton) {
        
    }
    
    
    
}
