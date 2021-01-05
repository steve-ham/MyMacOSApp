//
//  CollectionDiffableVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

private enum Section: CaseIterable {
    case custom
    case system
}

class CollectionDiffableVC: NSViewController, NSSearchFieldDelegate {
    
    @IBOutlet private weak var searchField: NSSearchField!
    @IBOutlet private weak var collectionView: NSCollectionView!
    
    private class DataSource: NSCollectionViewDiffableDataSource<Section, SystemIcon> {
        func apply(_ systemIcons: [SystemIcon], animatingDifferences: Bool = true, searchText: String = "") {
            let filteredSystemIcons = searchText.isEmpty ? systemIcons : systemIcons.filter { $0.name.localizedStandardContains(searchText) }
            let sortedIcons = filteredSystemIcons.sorted { $0.name < $1.name }
            let customIcons = sortedIcons.filter { $0.userAdded }
            let systemIcons = sortedIcons.filter { !$0.userAdded }
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, SystemIcon>()
            if !customIcons.isEmpty {
                snapshot.appendSections([.custom])
                snapshot.appendItems(customIcons, toSection: .custom)
            }
            snapshot.appendSections([.system])
            snapshot.appendItems(systemIcons)
            apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
    private var dataSource: DataSource!
    private lazy var systemIcons = {
        names.map { SystemIcon(name: $0, userAdded: false) }
    }()
    
    private let names = [
        NSImage.followLinkFreestandingTemplateName,
        NSImage.invalidDataFreestandingTemplateName,
        NSImage.refreshFreestandingTemplateName,
        NSImage.revealFreestandingTemplateName,
        NSImage.stopProgressFreestandingTemplateName,
        NSImage.menuMixedStateTemplateName,
        NSImage.menuOnStateTemplateName,
        NSImage.multipleDocumentsName,
        NSImage.everyoneName,
        NSImage.userName,
        NSImage.userGroupName,
        NSImage.userGuestName,
        NSImage.advancedName,
        NSImage.preferencesGeneralName,
        NSImage.userAccountsName,
        NSImage.statusAvailableName,
        NSImage.statusNoneName,
        NSImage.statusPartiallyAvailableName,
        NSImage.statusUnavailableName,
        NSImage.applicationIconName,
        NSImage.bonjourName,
        NSImage.folderBurnableName,
        NSImage.cautionName,
        NSImage.computerName,
        NSImage.folderName,
        NSImage.homeTemplateName,
        NSImage.networkName,
        NSImage.folderSmartName,
        NSImage.trashEmptyName,
        NSImage.trashFullName,
        NSImage.colorPanelName,
        NSImage.fontPanelName,
        NSImage.infoName,
        NSImage.mobileMeName
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewItem2.self, forItemWithIdentifier: CollectionViewItem2.identifier)
        collectionView.collectionViewLayout = createLayout()
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, systemIcon -> NSCollectionViewItem? in
            let collectionViewItem = collectionView.makeItem(withIdentifier: CollectionViewItem2.identifier, for: indexPath)
            collectionViewItem.textField?.stringValue = systemIcon.name
            collectionViewItem.imageView?.image = NSImage(named: systemIcon.name)
            return collectionViewItem
        }
        dataSource.apply(systemIcons)
    }
    
    private func createLayout() -> NSCollectionViewLayout {
        NSCollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = Int(contentSize.width / 400) + 1
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        systemIcons.append(SystemIcon(name: NSImage.mobileMeName, userAdded: true))
        dataSource.apply(systemIcons)
    }
    
    @IBAction private func clickMinusButton(_ sender: NSButton) {
        var snapshot = dataSource.snapshot()
        systemIcons.removeAll { $0.userAdded }
        snapshot.deleteSections([.custom])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - NSSearchFieldDelegate
    
    func controlTextDidChange(_ notification: Notification) {
        guard let nsSearchField = notification.object as? NSSearchField else { return }
        dataSource.apply(systemIcons, searchText: nsSearchField.stringValue)
    }
}
