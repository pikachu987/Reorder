//
//  Reorder.swift
//  Example
//
//  Created by Gwanho Kim on 2019/11/14.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

// 위아래 스크롤
// 겹칠때 타이밍 enum
// longGesture Time인터벌
// 네비게이션 위로... ? 탭컨트롤러 위로...?
// 제스쳐가 아니라 이벤트 발생바로 되게하는 펑션

import UIKit

public class Reorder {
    weak var scrollView: UIScrollView?
    
    public var snapshotRadius: CGFloat = 0
    public var scale: Scale = .medium
    
    private var beforeIndexPath: IndexPath?
    private var touchPoint: CGPoint?
    private var snapshotView: UIView?
    private var beforeGesturePoint: CGPoint?
    
    var reorderDelegate: ReorderDelegate? {
        return nil
    }
    
    var collectionType: CollectionType {
        return .default
    }
    
    var isMoveUpDown: Bool {
        return true
    }
    
    init() {
        
    }
    
    @objc func longPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            self.began(gestureRecognizer: gestureRecognizer)
        case .changed:
            self.changed(gestureRecognizer: gestureRecognizer)
        case .ended, .cancelled, .failed, .possible:
            self.ended(gestureRecognizer: gestureRecognizer)
        default: break
        }
    }
    
    private func began(gestureRecognizer: UILongPressGestureRecognizer) {
        let point = gestureRecognizer.location(in: self.scrollView)
        guard let indexPath = self.scrollView?.indexPath(at: point),
            let cell = self.scrollView?.cell(at: indexPath) else { return }
        if !self.canMove(indexPath: indexPath) { return }
        
        self.reorderDelegate?.reorderBegan()
        self.beforeIndexPath = indexPath
        
        var frame = cell.convert(cell.bounds, to: self.reorderDelegate?.reorderSuperview)
        if self.snapshotView == nil {
            let imageView = UIImageView()
            if let cell = cell as? ReorderCell {
                imageView.image = cell.reorderSnapshotView.imageWithView
                frame = cell.reorderSnapshotView.convert(cell.reorderSnapshotView.bounds, to: self.reorderDelegate?.reorderSuperview)
            } else {
                imageView.image = cell.imageWithView
            }
            imageView.layer.zPosition = 1024
            imageView.layer.cornerRadius = self.snapshotRadius
            imageView.clipsToBounds = true
            self.reorderDelegate?.reorderSuperview.addSubview(imageView)
            self.snapshotView = imageView
        }
        
        let scale = self.scale.scale
        let width = frame.size.width * scale
        let height = frame.size.height * scale
        let x = frame.origin.x - (width - frame.size.width)/2
        let y = frame.origin.y - (height - frame.size.height)/2
        self.snapshotView?.frame = CGRect(x: x, y: y, width: width, height: height)
        self.beforeGesturePoint = CGPoint(x: x, y: y)

        if self.touchPoint == nil {
            self.touchPoint = gestureRecognizer.location(in: cell)
        }
        cell.cellContentView?.alpha = 0
    }
    
    private func changed(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let touchPoint = self.touchPoint else { return }
        guard let beforeGesturePoint = self.beforeGesturePoint else { return }

        let gestureLocation = gestureRecognizer.location(in: self.reorderDelegate?.reorderSuperview)
        let viewLocation = gestureRecognizer.location(in: self.scrollView)

        let gestureExactPoint = CGPoint(x: gestureLocation.x - touchPoint.x, y: gestureLocation.y - touchPoint.y)
        let viewExactPoint = CGPoint(x: viewLocation.x - touchPoint.x, y: viewLocation.y - touchPoint.y)
        let isUp = beforeGesturePoint.y - gestureExactPoint.y > 0
        let isLeft = beforeGesturePoint.x - gestureExactPoint.x > 0
        
        self.beforeGesturePoint?.y = gestureExactPoint.y
        self.snapshotView?.frame.origin.y = gestureExactPoint.y
        
        if self.isMoveUpDown {
            self.beforeGesturePoint?.x = gestureExactPoint.x
            self.snapshotView?.frame.origin.x = gestureExactPoint.x
        }
        
        let width = self.snapshotView?.bounds.width ?? 0
        let height = self.snapshotView?.bounds.height ?? 0

        var indexPath: IndexPath?

        let minY = isUp ? viewExactPoint.y + (height / 3) : viewExactPoint.y + (height / 3 * 2)
        let maxY = isUp ? viewExactPoint.y + height : viewExactPoint.y
        let minX = isLeft ? viewExactPoint.x + (width / 3) : viewExactPoint.x + (width / 3 * 2)
        let maxX = isLeft ? viewExactPoint.x + width : viewExactPoint.x

        if let minIndexPath = self.scrollView?.indexPath(at: CGPoint(x: minX, y: minY)) {
            indexPath = minIndexPath
        } else if let maxIndexPath = self.scrollView?.indexPath(at: CGPoint(x: maxX, y: maxY)) {
            indexPath = maxIndexPath
        }
        
        if let beforeIndexPath = self.beforeIndexPath,
            let afterIndexPath = indexPath,
            beforeIndexPath != afterIndexPath && self.canMove(indexPath: afterIndexPath) {
            self.updateIndexPath(at: beforeIndexPath, to: afterIndexPath)
            
            self.scrollView?.move(at: beforeIndexPath, to: afterIndexPath)
            self.scrollView?.cell(at: beforeIndexPath)?.cellContentView?.alpha = 1
            self.scrollView?.cell(at: afterIndexPath)?.cellContentView?.alpha = 0
            self.beforeIndexPath = afterIndexPath
            self.reorderDelegate?.reorderChanged()
        }
    }
    
    private func ended(gestureRecognizer: UILongPressGestureRecognizer) {
        if let indexPath = self.beforeIndexPath {
            self.scrollView?.cell(at: indexPath)?.cellContentView?.alpha = 1
            self.reorderDelegate?.reorderEnded()
        }
        self.snapshotView?.removeFromSuperview()
        self.snapshotView = nil
        self.touchPoint = nil
        self.beforeGesturePoint = nil
        self.beforeIndexPath = nil
    }
    
    func updateIndexPath(at: IndexPath, to: IndexPath) {
        
    }
    
    func canMove(indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: Reorder + CollectionType
extension Reorder {
    enum CollectionType {
        case `default`
        case tableView
        case collectionView
    }
}

extension Reorder {
    public enum Scale {
        case custom(CGFloat)
        case none
        case small
        case medium
        case large
        
        var scale: CGFloat {
            switch self {
            case .none: return 1
            case .small: return 1.02
            case .medium: return 1.05
            case .large: return 1.08
            case .custom(let scale): return scale
            }
        }
    }
}
