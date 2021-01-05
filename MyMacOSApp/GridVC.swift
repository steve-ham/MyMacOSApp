//
//  GridVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class GridVC: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let separator = NSBox()
        separator.boxType = .separator
        let grid = NSGridView(views: [
            [NSTextField(labelWithString: "Show scroll bars:"), NSButton(radioButtonWithTitle: "Automatically based on mouse or trackpad", target: nil, action: nil)],
            [NSGridCell.emptyContentView, NSButton(radioButtonWithTitle: "When scrolling", target: nil, action: nil)],
            [NSGridCell.emptyContentView, NSButton(radioButtonWithTitle: "Always", target: nil, action: nil)],
            [NSTextField(labelWithString: "Click in the scroll bar to:"), NSButton(radioButtonWithTitle: "Jump to the next page", target: nil, action: nil)],
            [separator],
            [NSTextField(labelWithString: "Button:"), NSButton(title: "Button", target: nil, action: nil)],
        ])
        grid.translatesAutoresizingMaskIntoConstraints = false
        
        // Make first column stick to right
        grid.column(at: 0).xPlacement = .trailing
        
        // "Click in the scroll bar to:" top padding
        grid.row(at: 3).topPadding = 10
        
        // Merging separator to make the line long
        let separatorRow = grid.row(at: 4)
        separatorRow.mergeCells(in: NSRange(location: 0, length: 2))
        separatorRow.topPadding = 16
        separatorRow.bottomPadding = 16
        
        // Button: Button align by text baseline
        grid.rowAlignment = .firstBaseline
        
        view.addSubview(grid)
        
        NSLayoutConstraint.activate([
            grid.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grid.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
