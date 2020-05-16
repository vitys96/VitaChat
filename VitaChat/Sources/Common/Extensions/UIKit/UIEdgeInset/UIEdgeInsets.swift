//
//  UIEdgeInsets.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 10.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    init(topInset: CGFloat = 0, leftInset: CGFloat = 0, bottomInset: CGFloat = 0, rightInset: CGFloat = 0) {
        self.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }

    init(equal value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    init(verticalInset: CGFloat = 0, horizontalInset: CGFloat = 0) {
        self.init(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }

}
