//
//  ListViewController.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/19.
//

import Cocoa

class ListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    private var subjects = ["TableViewVC", "DatePickerVC", "SliderVC", "PopUpButtonVC", "ImageViewVC", "MenuVC", "DragAndDropVC", "MouseEventsVC", "KeyboardEventsVC", "CoreDataVC", "PopoverVC", "AlertVC", "CustomSheetVC", "CollectionViewVC", "SharingVC", "SplitViewVC", "PrintVC", "OutlineVC", "ViewBasedTableVC", "CustomButtonVC", "DragAndDropTableVC", "TableDiffableVC", "QuickLookVC", "UndoManagerVC", "GestureVC", "AutoLayoutVC", "PresentationAnimatorVC", "CompositionalLayoutVC", "WindowControllerVC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        cell.textField?.stringValue = subjects[row]
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let splitViewController = parent as? NSSplitViewController, let tableView = notification.object as? NSTableView else { return }
        
        print("hsteve tableView.selectedRow \(tableView.selectedRow)")
        let subject = subjects[tableView.selectedRow]
        
        let storyboard = NSStoryboard(name: "Main", bundle: .main)
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
        } else if let vc = c as? CoreDataVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? PopoverVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? AlertVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? CustomSheetVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? CollectionViewVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? SharingVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? SplitViewVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? PrintVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? OutlineVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? ViewBasedTableVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? CustomButtonVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? DragAndDropTableVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? TableDiffableVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? QuickLookVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? UndoManagerVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? GestureVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? AutoLayoutVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? PresentationAnimatorVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? CompositionalLayoutVC {
            splitViewController.children[1] = vc
        } else if let vc = c as? WindowControllerVC {
            splitViewController.children[1] = vc
        }
    }
}
