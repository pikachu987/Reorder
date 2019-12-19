//
//  ReorderCell.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/17.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

public protocol ReorderCell: class {
    var reorderSnapshotView: UIView { get }
}
