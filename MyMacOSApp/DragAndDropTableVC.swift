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
    private var draggingNSRange = NSMakeRange(0, 0)
    private var draggingDragAndDropImages = [DragAndDropImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - NSTableViewDataSource
    
    func tableView(_ tableView: NSTableView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forRowIndexes rowIndexes: IndexSet) {
        guard let firstIndex = rowIndexes.first, let lastIndex = rowIndexes.last else { return }
        let length = (lastIndex + 1) - firstIndex
        draggingNSRange = NSMakeRange(firstIndex, length)
        draggingDragAndDropImages.removeAll()
        rowIndexes.forEach { index in
            draggingDragAndDropImages.append(dragAndDropImages[index])
        }
    }
    
    func tableView(_ tableView: NSTableView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        draggingNSRange = NSMakeRange(0, 0)
        draggingDragAndDropImages.removeAll()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        dragAndDropImages.count
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        if draggingDragAndDropImages.count == 0 || info.draggingSourceOperationMask == .copy {
            var insertionIndex = row
            info.enumerateDraggingItems(options: .concurrent, for: tableView, classes: [DragAndDropImage.self], searchOptions: [:]) { [weak self] draggingItem, index, _ in
                guard let self = self, let dragAndDropImage = draggingItem.item as? DragAndDropImage else { return }
                self.dragAndDropImages.insert(dragAndDropImage, at: insertionIndex)
                self.tableView.reloadData()
                draggingItem.draggingFrame = self.tableView.frameOfCell(atColumn: 0, row: insertionIndex)
                insertionIndex += 1
            }
        } else {
            info.enumerateDraggingItems(options: .concurrent, for: tableView, classes: [DragAndDropImage.self], searchOptions: [:]) { [weak self] draggingItem, index, _ in
                guard let self = self else { return }
                var newIndex = row + index
                let dragAndDropImage = self.draggingDragAndDropImages[index]
                let oldIndex = self.dragAndDropImages.firstIndex(where: { $0.id == dragAndDropImage.id })!
                if oldIndex < newIndex {
                    newIndex -= (index + 1)
                }
                self.dragAndDropImages.remove(at: oldIndex)
                self.dragAndDropImages.insert(dragAndDropImage, at: newIndex)
            }
            tableView.reloadData()
        }
        
        return true
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        dragAndDropImages[row]
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        if !draggingDragAndDropImages.isEmpty && (row > draggingNSRange.lowerBound && row < draggingNSRange.upperBound) { return [] }
        if dropOperation == .above {
            if info.draggingSource as? NSObject == tableView { // Reorder
                if info.draggingSourceOperationMask == .copy { // Holding down option key
                    info.animatesToDestination = true
                    return .copy
                } else {
                    return .move
                }
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
    
    // MARK: - NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTableCellView else { return nil }
        cell.imageView?.image = NSImage(contentsOf: dragAndDropImages[row].nsURL as URL)
        cell.textField?.stringValue = dragAndDropImages[row].name
        return cell
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
        tableView.selectedRowIndexes.reversed().forEach { [weak self] index in
            guard let self = self else { return }
            self.dragAndDropImages.remove(at: index)
        }
        tableView.reloadData()
    }
}
