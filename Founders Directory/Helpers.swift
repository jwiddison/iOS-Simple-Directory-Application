//
//  Helpers.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

extension UIImageView {
    func applyBorder() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.3
    }

    func applyCircleMask() {
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}

extension UINavigationController {
    func makeBarTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = UIColor.clear
        navigationBar.backgroundColor = UIColor.clear
    }
    
    func resetBarTransparency() {
        navigationBar.setBackgroundImage(nil, for: .default)
    }
}
