//
//  Helper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class Helper {
    // NEEDSWORK: a better way to do this is an extension of UIImageView; I'll show this later

    static func applyRoundBorder(to imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2.0
    }
}
