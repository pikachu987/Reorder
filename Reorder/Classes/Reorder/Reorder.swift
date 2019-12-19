//Copyright (c) 2019 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit

public class Reorder {
    weak var scrollView: UIScrollView?
    
    public var scale: Scale = .medium
    public var overlapBehaviour: OverlapBehaviour = .twoThirds
    
    public var snapshotRadius: CGFloat = 0
    public var minimumPressDuration: TimeInterval = 0.5
    
    public var scrollFrame: CGRect?
    
    // Enabled Auto Scroll
    private var isScrollEnabled = true
    
    // Gesture
    private var beforeIndexPath: IndexPath?
    private var touchPoint: CGPoint?
    private var beforeGesturePoint: CGPoint?
    
    // Snapshot
    private var snapshotView: UIView?
    
    var reorderDelegate: ReorderDelegate? {
        return nil
    }
    
    var isMoveUpDown: Bool {
        return true
    }
    
    init() {
        
    }
    
    @objc public func longPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
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
    
    // Began
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
    
    // Changed
    private func changed(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let touchPoint = self.touchPoint else { return }
        guard let beforeGesturePoint = self.beforeGesturePoint else { return }
        
        let gestureLocation = gestureRecognizer.location(in: self.reorderDelegate?.reorderSuperview)
        let viewLocation = gestureRecognizer.location(in: self.scrollView)

        let gestureExactPoint = CGPoint(x: gestureLocation.x - touchPoint.x, y: gestureLocation.y - touchPoint.y)
        let viewExactPoint = CGPoint(x: viewLocation.x - touchPoint.x, y: viewLocation.y - touchPoint.y)
        let isUp = beforeGesturePoint.y - gestureExactPoint.y > 0
        let isLeft = beforeGesturePoint.x - gestureExactPoint.x > 0
        
        // Top & Bottom Auto Scroll
        if let scrollFrame = self.scrollFrame, self.isScrollEnabled {
            if isUp && scrollFrame.origin.y > gestureExactPoint.y {
                self.scrollView?.scrollToTop { (isScrollEnabled) in
                    self.isScrollEnabled = isScrollEnabled
                }
            } else if !isUp && scrollFrame.size.height < gestureExactPoint.y {
                self.scrollView?.scrollToBottom { (isScrollEnabled) in
                    self.isScrollEnabled = isScrollEnabled
                }
            }
        }
        
        self.beforeGesturePoint?.y = gestureExactPoint.y
        self.snapshotView?.frame.origin.y = gestureExactPoint.y
        
        if self.isMoveUpDown { // Not Only Vertical Move
            self.beforeGesturePoint?.x = gestureExactPoint.x
            self.snapshotView?.frame.origin.x = gestureExactPoint.x
        }
        
        let width = self.snapshotView?.bounds.width ?? 0
        let height = self.snapshotView?.bounds.height ?? 0
        
        let minY = isUp ? viewExactPoint.y + self.overlapBehaviour.minus(height) : viewExactPoint.y + self.overlapBehaviour.plus(height)
        let maxY = isUp ? viewExactPoint.y + height : viewExactPoint.y
        let minX = isLeft ? viewExactPoint.x + self.overlapBehaviour.minus(width) : viewExactPoint.x + self.overlapBehaviour.plus(width)
        let maxX = isLeft ? viewExactPoint.x + width : viewExactPoint.x
        
        var indexPath: IndexPath?
        
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
    
    // Ended
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

// MARK: Reorder + Scale
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

// MARK: Reorder + OverlapBehaviour
extension Reorder {
    public enum OverlapBehaviour {
        case oneThird
        case half
        case twoThirds
        
        // UP & LEFT
        func minus(_ value: CGFloat) -> CGFloat {
            switch self {
            case .oneThird: return value / 3 * 1
            case .half: return value / 2
            case .twoThirds: return value / 3 * 2
            }
        }
        
        // DOWN & BOTTOM
        func plus(_ value: CGFloat) -> CGFloat {
            switch self {
            case .oneThird: return value / 3 * 2
            case .half: return value / 2
            case .twoThirds: return value / 3 * 1
            }
        }
    }
}
