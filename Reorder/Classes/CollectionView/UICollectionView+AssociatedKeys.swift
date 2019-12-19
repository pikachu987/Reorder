//
//  UICollectionView+AssociatedKeys.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UICollectionView {
    private struct AssociatedKeys {
        static var reorder: UInt8 = 0
    }
    
    public var reorder: CollectionViewReorder {
        if let reorder = objc_getAssociatedObject(self, &AssociatedKeys.reorder) as? CollectionViewReorder {
            return reorder
        } else {
            let reorder = CollectionViewReorder(collectionView: self)
            objc_setAssociatedObject(self, &AssociatedKeys.reorder, reorder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return reorder
        }
    }
}
