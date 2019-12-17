//
//  CollectionViewReorderDelegate.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

public protocol CollectionViewReorderDelegate: ReorderDelegate {
    func collectionViewReorder(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func collectionViewReorder(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
}

public extension CollectionViewReorderDelegate {
    func collectionViewReorder(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
