//
//  UIView+SafeArea.swift
//  Reorder
//
//  Created by Gwanho Kim on 2019/12/18.
//

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
