//
//  CompositionalLayoutVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/05.
//

import Cocoa

class CompositionalLayoutVC: NSViewController, NSCollectionViewDataSource {

    @IBOutlet private weak var collectionView: NSCollectionView! {
        didSet {
            collectionView.register(CollectionViewItem.self, forItemWithIdentifier: CollectionViewItem.identifier)
            collectionView.collectionViewLayout = bidirectionalLayout()
        }
    }
    
    // Bidirection Scrolling
    private func bidirectionalLayout() -> NSCollectionViewLayout {
        let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
        item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
        item2.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: item2, count: 2)
        
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.4), heightDimension: .fractionalHeight(0.5)), subitems: [item1, group1])
        let section = NSCollectionLayoutSection(group: group2)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = NSCollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // MARK: - NSCollectionViewDataSource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: CollectionViewItem.identifier, for: indexPath)
        item.textField?.stringValue = "\(indexPath.section), \(indexPath.item)"
        return item
    }
}
