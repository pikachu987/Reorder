//
//  UIScrollView+IndexPath.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UIScrollView {
    var firstIndexPath: IndexPath? {
        if let tableView = self as? UITableView {
            return tableView.indexPathsForVisibleRows?.sorted(by: { (left, right) -> Bool in
                if left.section == right.section { return left.row < right.row }
                else { return left.section < right.section }
            }).first
        } else if let collectionView = self as? UICollectionView {
            return collectionView.indexPathsForVisibleItems.sorted(by: { (left, right) -> Bool in
                if left.section == right.section { return left.item < right.item }
                else { return left.section < right.section }
            }).first
        } else {
            return nil
        }
    }
    
    var lastIndexPath: IndexPath? {
        if let tableView = self as? UITableView {
            return tableView.indexPathsForVisibleRows?.sorted(by: { (left, right) -> Bool in
                if left.section == right.section { return left.row > right.row }
                else { return left.section > right.section }
            }).first
        } else if let collectionView = self as? UICollectionView {
            return collectionView.indexPathsForVisibleItems.sorted(by: { (left, right) -> Bool in
                if left.section == right.section { return left.item > right.item }
                else { return left.section > right.section }
            }).first
        } else {
            return nil
        }
    }
    
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
    
    func scrollToTop(_ callback: @escaping ((Bool) -> Void)) {
        guard let firstIndexPath = self.firstIndexPath else { return }
        if let tableView = self as? UITableView {
            let scrollIndexPath: IndexPath
            if firstIndexPath.section == 0 && firstIndexPath.row == 0 {
                scrollIndexPath = firstIndexPath
            } else if firstIndexPath.row == 0 {
                let row = tableView.numberOfRows(inSection: firstIndexPath.section - 1) - 1
                scrollIndexPath = IndexPath(row: row, section: firstIndexPath.section - 1)
            } else {
                scrollIndexPath = IndexPath(row: firstIndexPath.row - 1, section: firstIndexPath.section)
            }
            callback(false)
            UIView.animate(withDuration: 0.3, animations: {
                tableView.scrollToRow(at: scrollIndexPath, at: .top, animated: false)
            }) { (finished) in
                callback(true)
            }
        } else if let collectionView = self as? UICollectionView {
            let scrollIndexPath: IndexPath
            if firstIndexPath.section == 0 && firstIndexPath.item == 0 {
                scrollIndexPath = firstIndexPath
            } else if firstIndexPath.item == 0 {
                let item = collectionView.numberOfItems(inSection: firstIndexPath.section - 1) - 1
                scrollIndexPath = IndexPath(item: item, section: firstIndexPath.section - 1)
            } else {
                scrollIndexPath = IndexPath(item: firstIndexPath.item - 1, section: firstIndexPath.section)
            }
            callback(false)
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.scrollToItem(at: scrollIndexPath, at: .top, animated: false)
            }) { (finished) in
                callback(true)
            }
        }
    }
    
    func scrollToBottom(_ callback: @escaping ((Bool) -> Void)) {
        guard let lastIndexPath = self.lastIndexPath else { return }
        if let tableView = self as? UITableView {
            let lastSection = tableView.numberOfSections - 1
            let lastSectionLastRow = tableView.numberOfRows(inSection: lastSection) - 1
            let currentSectionLastRow = tableView.numberOfRows(inSection: lastIndexPath.section) - 1
            let scrollIndexPath: IndexPath
            if lastIndexPath.section == lastSection && lastIndexPath.row == lastSectionLastRow {
                scrollIndexPath = lastIndexPath
            } else if lastIndexPath.row == currentSectionLastRow {
                scrollIndexPath = IndexPath(row: 0, section: lastIndexPath.section + 1)
            } else {
                scrollIndexPath = IndexPath(row: lastIndexPath.row + 1, section: lastIndexPath.section)
            }
            callback(false)
            UIView.animate(withDuration: 0.3, animations: {
                tableView.scrollToRow(at: scrollIndexPath, at: .bottom, animated: false)
            }) { (finished) in
                callback(true)
            }
        } else if let collectionView = self as? UICollectionView {
            let lastSection = collectionView.numberOfSections - 1
            let lastSectionLastItem = collectionView.numberOfItems(inSection: lastSection) - 1
            let currentSectionLastItem = collectionView.numberOfItems(inSection: lastIndexPath.section) - 1
            let scrollIndexPath: IndexPath
            if lastIndexPath.section == lastSection && lastIndexPath.item == lastSectionLastItem {
                scrollIndexPath = lastIndexPath
            } else if lastIndexPath.item == currentSectionLastItem {
                scrollIndexPath = IndexPath(item: 0, section: lastIndexPath.section + 1)
            } else {
                scrollIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
            }
            callback(false)
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.scrollToItem(at: scrollIndexPath, at: .bottom, animated: false)
            }) { (finished) in
                callback(true)
            }
        }
    }
}
