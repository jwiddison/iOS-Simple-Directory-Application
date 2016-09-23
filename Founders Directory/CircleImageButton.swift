//
//  CircleImageButton.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/22/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//
//  See http://bit.ly/2cKVhzm for inspiration.
//

import UIKit

class CircleImageButton : UIButton {

    // MARK: - Constants

    private struct Animation {
        static let Duration = 0.15
        static let AlphaFade: CGFloat = 0.3
        static let AlphaOpaque: CGFloat = 1.0
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame:frame)
        adjustsImageWhenHighlighted = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        adjustsImageWhenHighlighted = false
    }

    // MARK: - View lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }

    // MARK: - Touch events

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: Animation.Duration) {
            self.alpha = Animation.AlphaFade
        }

        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: Animation.Duration) {
            self.alpha = Animation.AlphaOpaque
        }

        super.touchesEnded(touches, with: event)
    }
    
    // MARK: - Helpers
    
    func setEnabledState(_ enabled: Bool, including label: UILabel) {
        isEnabled = enabled
        label.isEnabled = enabled

        if !enabled {
            backgroundColor = UIColor.clear
        }
    }
}
