//
//  CollectionViewReorder.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

public class CollectionViewReorder: Reorder {
    public weak var delegate: CollectionViewReorderDelegate?
    
    override var reorderDelegate: ReorderDelegate? {
        return self.delegate
    }
    
    public lazy var gestureRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
    }()
    
    public init(collectionView: UICollectionView) {
        super.init()
        self.gestureRecognizer.minimumPressDuration = self.minimumPressDuration
        collectionView.addGestureRecognizer(self.gestureRecognizer)
        self.scrollView = collectionView
    }
    
    override func updateIndexPath(at: IndexPath, to: IndexPath) {
        guard let collectionView = self.scrollView as? UICollectionView else { return }
        self.delegate?.collectionViewReorder(collectionView, moveItemAt: at, to: to)
    }
    
    override func canMove(indexPath: IndexPath) -> Bool {
        guard let collectionView = self.scrollView as? UICollectionView else { return true }
        return self.delegate?.collectionViewReorder(collectionView, canMoveItemAt: indexPath) ?? true
    }
}
