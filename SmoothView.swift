//
//  SmoothView.swift
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-24.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

import UIKit

class SmoothView: UIView {

    private var flx_lastSetRadius : CGFloat = 0
    private var flx_smoothMask : CAShapeLayer?

    var flx_smoothCorners: Bool = false {
        didSet {
            updateMaskIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if (flx_continuousCorners) {
            updateMaskIfNeeded()
        }
    }

    func updateMaskIfNeeded() {
        if (flx_smoothCorners) {
            if let maskBounds = flx_smoothMask?.path?.boundingBoxOfPath {
                if (!bounds.equalTo(maskBounds)
                    || flx_lastSetRadius != layer.cornerRadius) {
                    updateMaskShape()
                }
            } else {
                let path = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: layer.cornerRadius)
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
                flx_smoothMask = mask
                flx_lastSetRadius = layer.cornerRadius

                layer.addObserver(self,
                            forKeyPath: NSStringFromSelector(#selector(getter: CALayer.cornerRadius)),
                            options: [],
                            context: nil)
            }
        }
        else if (flx_smoothMask != nil) {
            layer.mask = nil
            flx_smoothMask = nil

            layer.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: CALayer.cornerRadius)))
        }
    }

    func updateMaskShape() {
        flx_smoothMask?.path = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: layer.cornerRadius).cgPath
        flx_lastSetRadius = layer.cornerRadius
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == NSStringFromSelector(#selector(getter: CALayer.cornerRadius))) {
            updateMaskIfNeeded()
        }
    }
}
