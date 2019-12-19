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

public class TableViewReorder: Reorder {
    public weak var delegate: TableViewReorderDelegate?
    
    public var isMoveVertical = false
    
    override var reorderDelegate: ReorderDelegate? {
        return self.delegate
    }
    
    override var isMoveUpDown: Bool {
        return self.isMoveVertical
    }
    
    public lazy var gestureRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGesture(_:)))
    }()
    
    public init(tableView: UITableView) {
        super.init()
        self.gestureRecognizer.minimumPressDuration = self.minimumPressDuration
        tableView.addGestureRecognizer(self.gestureRecognizer)
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
