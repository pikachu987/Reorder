//
//  UIView+cellContentView.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UIView {
    var cellContentView: UIView? {
        if let cell = self as? UITableViewCell {
            return cell.contentView
        } else if let cell = self as? UICollectionViewCell {
            return cell.contentView
        } else {
            return nil
        }
    }
}

