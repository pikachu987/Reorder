//
//  TableViewCell.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit
import Reorder

class TableViewCell: UITableViewCell, ReorderCell {
    static let identifier = "TableViewCell"

    var reorder: ReorderModel? {
        didSet {
            guard let reorder = self.reorder else { return }
            self.colorView.backgroundColor = reorder.color
            if reorder.canMove {
                self.indexLabel.text = reorder.key
            } else {
                self.indexLabel.text = "\(reorder.key) can't move"
            }
        }
    }
    
    var reorderSnapshotView: UIView {
        return self.colorView
    }

    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.contentView.addSubview(self.colorView)
        self.colorView.addSubview(self.indexLabel)
        
        self.contentView.addConstraints([
            NSLayoutConstraint(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self.colorView, attribute: .leading, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self.colorView, attribute: .trailing, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self.colorView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self.colorView, attribute: .bottom, multiplier: 1, constant: 10)
        ])
        
        self.colorView.addConstraints([
            NSLayoutConstraint(item: self.colorView, attribute: .leading, relatedBy: .equal, toItem: self.indexLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.colorView, attribute: .trailing, relatedBy: .equal, toItem: self.indexLabel, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.colorView, attribute: .top, relatedBy: .equal, toItem: self.indexLabel, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.colorView, attribute: .bottom, relatedBy: .equal, toItem: self.indexLabel, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
