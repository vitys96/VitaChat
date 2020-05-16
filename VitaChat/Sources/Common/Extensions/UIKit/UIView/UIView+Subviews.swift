//
//  UIView+Subviews.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIView

extension UIView {

    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

}
