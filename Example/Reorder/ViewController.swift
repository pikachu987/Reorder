//
//  ViewController.swift
//  Reorder
//
//  Created by pikachu987 on 12/18/2019.
//  Copyright (c) 2019 pikachu987. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 56
        return tableView
    }()
    
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
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let viewController = ReorderTableViewExampleViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 1 {
            let viewController = MultipleSectionTableViewExampleViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 2 {
            let viewController = ReorderCollectionViewExampleViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 3 {
            let viewController = MultipleSectionCollectionViewExampleViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            cell.textLabel?.text = "TableView Row Reorder"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "TableView Multiple Sections Reorder"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "CollectionView Row Reorder"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "CollectionView Multiple Sections Reorder"
        }
        return cell
    }
}
