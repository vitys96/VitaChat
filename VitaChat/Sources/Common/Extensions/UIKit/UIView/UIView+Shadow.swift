//
//  UIView+Shadow.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIView

extension UIView {

    func addShadow(
        radius: CGFloat,
        opacity: Float,
        offset: CGSize = .zero,
        color: CGColor = UIColor.black.cgColor) {

        layer.shadowColor = color
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func removeShadow() {
        layer.shadowRadius = 0
    }

    func setupBorder(withColor color: UIColor, andWidth width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func rounded() {
        layer.cornerRadius = bounds.height / 2.0
    }

    func roundWithShadow(cornerRadius: CGFloat, shadowRadius: CGFloat, offset: CGSize = .zero,
                         shadowColor: CGColor = UIColor.black.cgColor) {
        clipsToBounds = true
//        layer.masksToBounds = false
//        layer.shouldRasterize = true
        layer.cornerRadius = cornerRadius
//        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.shadowColor = shadowColor
        layer.shadowOffset = offset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.4
        layer.rasterizationScale = UIScreen.main.scale
    }

}
