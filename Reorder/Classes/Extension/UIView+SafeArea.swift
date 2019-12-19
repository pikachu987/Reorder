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

struct SafeView {
    var header: CGFloat {
        return self.navigation + self.top
    }
    var navigation: CGFloat = 0
    var top: CGFloat = 0
    var left: CGFloat = 0
    var right: CGFloat = 0
    var bottom: CGFloat = 0
}

extension UIView {
    var safe: SafeView {
        var safeView = SafeView()
        if #available(iOS 11.0, *) {
            guard let keyWindow = UIApplication.shared.keyWindow else { return safeView }
            safeView.left = keyWindow.safeAreaInsets.left
            safeView.right = keyWindow.safeAreaInsets.right
            safeView.bottom = keyWindow.safeAreaInsets.bottom
        }
        safeView.top = UIApplication.shared.statusBarFrame.height
        let currentViewController = UIApplication.shared.currentViewController
        safeView.navigation = currentViewController?.navigationController?.navigationBar.frame.height ?? 0
        return safeView
    }
}

extension UIWindow {
    fileprivate var currentViewController: UIViewController? {
        return self.currentViewController(viewController: self.rootViewController)
    }
    
    private func currentViewController(viewController: UIViewController?) -> UIViewController? {
        if let viewController = viewController as? UINavigationController {
            if let currentViewController = viewController.visibleViewController {
                return self.currentViewController(viewController: currentViewController)
            } else {
                return viewController
            }
        } else if let viewController = viewController as? UITabBarController {
            if let currentViewController = viewController.selectedViewController {
                return self.currentViewController(viewController: currentViewController)
            } else {
                return viewController
            }
        } else {
            if let currentViewController = viewController?.presentedViewController {
                return self.currentViewController(viewController: currentViewController)
            } else {
                return viewController
            }
        }
    }
}

extension UIApplication {
    fileprivate var currentViewController: UIViewController? {
        return self.keyWindow?.currentViewController
    }
}
