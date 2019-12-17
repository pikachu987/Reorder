//
//  TableViewReorder.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

public class TableViewReorder: Reorder {
    public weak var delegate: TableViewReorderDelegate?
    
    public var isMoveVertical = false
    
    override var reorderDelegate: ReorderDelegate? {
        return self.delegate
    }
    
    override var collectionType: Reorder.CollectionType {
        return .tableView
    }
    
    override var isMoveUpDown: Bool {
        return self.isMoveVertical
    }
    
    public init(tableView: UITableView) {
        super.init()
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
        tableView.addGestureRecognizer(longPressGestureRecognizer)
        self.scrollView = tableView
    }
    
    override func updateIndexPath(at: IndexPath, to: IndexPath) {
        guard let tableView = self.scrollView as? UITableView else { return }
        self.delegate?.tableViewReorder(tableView, moveRowAt: at, to: to)
    }
    
    override func canMove(indexPath: IndexPath) -> Bool {
        guard let tableView = self.scrollView as? UITableView else { return true }
        return self.delegate?.tableViewReorder(tableView, canMoveRowAt: indexPath) ?? true
    }
}
