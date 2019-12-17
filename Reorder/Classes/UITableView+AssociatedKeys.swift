//
//  UITableView+AssociatedKeys.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UITableView {
    private struct AssociatedKeys {
        static var reorder: UInt8 = 0
    }
    
    public var reorder: TableViewReorder {
        if let reorder = objc_getAssociatedObject(self, &AssociatedKeys.reorder) as? TableViewReorder {
            return reorder
        } else {
            let reorder = TableViewReorder(tableView: self)
            objc_setAssociatedObject(self, &AssociatedKeys.reorder, reorder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return reorder
        }
    }
}
