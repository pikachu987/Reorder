//
//  TableViewReorderDelegate.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

public protocol TableViewReorderDelegate: ReorderDelegate {
    func tableViewReorder(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func tableViewReorder(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
}

public extension TableViewReorderDelegate {
    func tableViewReorder(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
