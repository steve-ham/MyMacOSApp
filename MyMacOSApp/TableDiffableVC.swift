//
//  TableDiffableVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class TableDiffableVC: NSViewController {
    
    @IBOutlet private weak var tableView: NSTableView!
    private enum Section {
        case main
    }
    private var foods = [Food(name: "apple"), Food(name: "banana")]
    private var dataSource: NSTableViewDiffableDataSource<Section, Food>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = NSTableViewDiffableDataSource<Section, Food>(tableView: tableView) { tableView, tableColumn, row, food -> NSView in
            let cell = tableView.makeView(withIdentifier: tableColumn.identifier, owner: self) as! NSTableCellView
            cell.textField?.stringValue = food.name
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(foods)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        foods.append(Food(name: "orange"))
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(foods)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
