//
//  ReorderTableViewExample.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit
import Reorder

class ReorderTableViewExampleViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = 80
        return tableView
    }()
    
    private var list = ReorderModel.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view ?? UIView()
        self.view.addSubview(self.tableView)
        self.view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.tableView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.tableView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.tableView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reorder.delegate = self
        self.tableView.reorder.scale = .large
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension ReorderTableViewExampleViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource
extension ReorderTableViewExampleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { fatalError() }
        cell.reorder = self.list[indexPath.row]
        return cell
    }
}

// MARK: TableViewReorderDelegate
extension ReorderTableViewExampleViewController: TableViewReorderDelegate {
    var reorderSuperview: UIView {
        return self.view
    }
    
    func tableViewReorder(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.list.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableViewReorder(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.list[indexPath.row].canMove
    }
}
