//
//  String+NSAttributedString.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

public extension String {

    func attributes(fontStyle: FontStyle, size: CGFloat, color: UIColor, kern: Double = 0) -> [NSAttributedString.Key: Any] {
        let fontManager = DIContainer.fontManager
        return [
            .font: fontManager.getFont(for: fontStyle, ofSize: size),
            .foregroundColor: color,
            .kern: kern == 0 ? String.kern(for: fontStyle) : kern,
        ]
    }
    func attributesForPrefferFont(fontStyle: UIFont.TextStyle, color: UIColor) -> [NSAttributedString.Key: Any] {
        return [
            .font: UIFont.preferredFont(forTextStyle: fontStyle),
            .foregroundColor: color
        ]
    }

    func addAttributesForPreffereddFont(fontStyle: UIFont.TextStyle, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributesForPrefferFont(fontStyle: fontStyle, color: color))
    }

    func addAttributes(fontStyle: FontStyle, size: CGFloat, color: UIColor, kern: Double = 0) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes(fontStyle: fontStyle,
                                                                       size: size, color: color, kern: kern))
    }

    private static let kernForFontStyle: [FontStyle: Double] = [
        FontStyle.black: 0.12,
        FontStyle.bold: 0.14,
        FontStyle.heavy: 0.07,
        FontStyle.light: -0.08,
        FontStyle.medium: -0.05,
        FontStyle.semibold: 0.08,
        FontStyle.thin: 0.1,
        FontStyle.ultralight: 0.07,
    ]

    private static func kern(for fontStyle: FontStyle) -> Double {
        return kernForFontStyle[fontStyle, default: 0.0]
    }

}

public enum FontStyle: String {
    case bold
    case black
    case heavy
    case light
    case medium
    case regular
    case semibold
    case thin
    case ultralight
}
