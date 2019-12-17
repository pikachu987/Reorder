//
//  Extension.swift
//  Example
//
//  Created by Gwanho Kim on 2019/11/14.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

extension UIView {
    var imageWithView: UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
            return renderer.image { rendererContext in
                self.layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            if let cgContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: cgContext)
            }
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
            UIGraphicsEndImageContext()
            return image
        }
    }
}
