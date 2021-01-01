//
//  CollectionViewVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/01.
//

import Cocoa

class CollectionViewVC: NSViewController, NSCollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: NSCollectionView!
    
    private var ints = [1, 2, 3, 4, 5]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - NSCollectionViewDataSource
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        ints.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("MyCollectionViewItem"), for: indexPath)
        guard let pictureItem = item as? MyCollectionViewItem else { return item }
        pictureItem.label.stringValue = "\(ints[indexPath.item])"
        return pictureItem
    }
    
    @IBAction private func clickAddButton(_ sender: NSButton) {
        ints.append(ints.count + 1)
        collectionView.reloadData()
    }
    
}
