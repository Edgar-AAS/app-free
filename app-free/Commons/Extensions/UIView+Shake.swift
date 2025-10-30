//
//  UIView+Shake.swift
//  app-free
//
//  Created by Lidia on 28/10/25.
//

import UIKit

extension UIView {

    func shake(duration: CFTimeInterval = 0.4, values: [CGFloat] = [-10, 10, -8, 8, -5, 5, 0]) {
                
        guard !self.frame.isEmpty, self.frame.width > 0, self.frame.height > 0 else {
            print("⚠️ Skipping shake for view with invalid frame: \(self)")
            return
        }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = values
        
        self.layer.add(animation, forKey: "shake")
    }
}
