//
//  MultipleSectionTableViewExampleViewController.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/12.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit
import Reorder

class MultipleSectionTableViewExampleViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = 80
        return tableView
    }()
    
    private var list = ReorderModel.sectionList
    
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
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension MultipleSectionTableViewExampleViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource
extension MultipleSectionTableViewExampleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.list.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { fatalError() }
        cell.reorder = self.list[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK: TableViewReorderDelegate
extension MultipleSectionTableViewExampleViewController: TableViewReorderDelegate {
    var reorderSuperview: UIView {
        return self.view
    }
    
    func tableViewReorder(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            self.list[sourceIndexPath.section].swapAt(sourceIndexPath.row, destinationIndexPath.row)
        } else {
            let sourceItem = self.list[sourceIndexPath.section][sourceIndexPath.row]
            self.list[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            self.list[destinationIndexPath.section].insert(sourceItem, at: destinationIndexPath.row)
        }
    }
    
    func tableViewReorder(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.list[indexPath.section][indexPath.row].canMove
    }
}
