//
//  MultipleSectionCollectionViewExampleViewController.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/12.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit
import Reorder

class MultipleSectionCollectionViewExampleViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3) - 10, height: 80)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    private var list = ReorderModel.sectionList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view ?? UIView()
        self.view.addSubview(self.collectionView)
        self.view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.collectionView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.collectionView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.collectionView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.collectionView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.collectionView.reorder.scrollFrame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 88)
        self.collectionView.reorder.delegate = self
    }
}

// MARK: UICollectionViewDelegate
extension MultipleSectionCollectionViewExampleViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MultipleSectionCollectionViewExampleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { fatalError() }
        cell.reorder = self.list[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK: CollectionViewReorderDelegate
extension MultipleSectionCollectionViewExampleViewController: CollectionViewReorderDelegate {
    var reorderSuperview: UIView {
        return self.navigationController?.view ?? UIView()
    }
    
    func collectionViewReorder(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            let item = self.list[sourceIndexPath.section][sourceIndexPath.item]
            self.list[sourceIndexPath.section].remove(at: sourceIndexPath.item)
            self.list[sourceIndexPath.section].insert(item, at: destinationIndexPath.item)
        } else {
            let sourceItem = self.list[sourceIndexPath.section][sourceIndexPath.row]
            self.list[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            self.list[destinationIndexPath.section].insert(sourceItem, at: destinationIndexPath.row)
        }
    }
    
    func collectionViewReorder(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return self.list[indexPath.section][indexPath.row].canMove
    }
}
