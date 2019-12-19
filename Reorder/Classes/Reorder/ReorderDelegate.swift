//
//  ReorderDelegate.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit
import AudioToolbox

public protocol ReorderDelegate: class {
    var reorderSuperview: UIView { get }
    func reorderBegan()
    func reorderChanged()
    func reorderEnded()
}

public extension ReorderDelegate {
    func reorderBegan() {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        } else {
            AudioServicesPlaySystemSound(1520)
        }
    }
    
    func reorderChanged() {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } else {
            AudioServicesPlaySystemSound(1519)
        }
    }
    
    func reorderEnded() {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        } else {
            AudioServicesPlaySystemSound(1520)
        }
    }
}
