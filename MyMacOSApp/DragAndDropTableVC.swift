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
            tableView.registerForDraggedTypes([.fileURL])
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
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView else { return nil }
        cell.imageView?.image = NSImage(contentsOf: dragAndDropImages[row].nsURL as URL)
        cell.textField?.stringValue = dragAndDropImages[row].name
        return cell
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        dragAndDropImages[row]
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        if dropOperation == .above {
            if info.draggingSource as? NSObject == tableView {
                // reorder
            } else {
                let options: [NSPasteboard.ReadingOptionKey : Any] = [NSPasteboard.ReadingOptionKey.urlReadingFileURLsOnly: true, NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes: NSImage.imageTypes]
                if info.draggingPasteboard.canReadObject(forClasses: [NSURL.self], options: options) {
                    info.animatesToDestination = true
                    return .copy
                }
            }
        }
        return []
    }
    
    func tableView(_ tableView: NSTableView, updateDraggingItemsForDrag draggingInfo: NSDraggingInfo) {
        if draggingInfo.draggingSource as? NSObject != tableView {
            let classes = [DragAndDropImage.self, NSPasteboardItem.self]
            
            let cell = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView)!
            
            var validCount = 0
            draggingInfo.enumerateDraggingItems(options: .concurrent, for: tableView, classes: classes, searchOptions: [:]) { draggingItem, index, _ in
                if draggingItem.item is DragAndDropImage, let dragAndDropImage = draggingItem.item as? DragAndDropImage {
                    draggingItem.draggingFrame = cell.frame
                    draggingItem.imageComponentsProvider = {
                        cell.imageView?.image = NSImage(contentsOf: dragAndDropImage.nsURL as URL)
                        cell.textField?.stringValue = dragAndDropImage.name
                        return cell.draggingImageComponents
                    }
                    validCount += 1
                } else {
                    draggingItem.imageComponentsProvider = nil
                }
            }
            draggingInfo.numberOfValidItemsForDrop = validCount
            draggingInfo.draggingFormation = .list
        }
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
