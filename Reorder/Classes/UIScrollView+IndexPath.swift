//
//  UIScrollView+IndexPath.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UIScrollView {
    func indexPath(at: CGPoint) -> IndexPath? {
        if let tableView = self as? UITableView {
            return tableView.indexPathForRow(at: at)
        } else if let collectionView = self as? UICollectionView {
            return collectionView.indexPathForItem(at: at)
        } else {
            return nil
        }
    }
    
    func cell(at: IndexPath) -> UIView? {
        if let tableView = self as? UITableView {
            return tableView.cellForRow(at: at)
        } else if let collectionView = self as? UICollectionView {
            return collectionView.cellForItem(at: at)
        } else {
            return nil
        }
    }
    
    func move(at: IndexPath, to: IndexPath) {
        if let tableView = self as? UITableView {
            tableView.moveRow(at: at, to: to)
        } else if let collectionView = self as? UICollectionView {
            collectionView.moveItem(at: at, to: to)
        }
    }
}
