//
//  UIImage+BundledImage.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIImage

extension UIImage {

    static func withName(_ name: String?) -> UIImage? {
        return name.flatMap { UIImage(named: $0, in: nil, compatibleWith: nil) }
    }

}
