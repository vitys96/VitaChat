//
//  FontManager.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class FontManager: FontManagerProtocol {

    // MARK: - Protocol properties
    static let shared: FontManagerProtocol = FontManager()

    // MARK: - Properties
    private var defaultFonts: FontDictionary?

    // MARK: - Typealias
    private typealias FontDictionary = [FontStyle.RawValue: String]

    // MARK: - Init
    private init() {
        guard let url = Bundle.main.url(forResource: "VitaFonts", withExtension: "plist"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        defaultFonts = try? PropertyListDecoder().decode(FontDictionary.self, from: data)
    }

    // MARK: - Public Methods
    func getFont(for style: FontStyle, ofSize size: CGFloat) -> UIFont {
        guard let fontName = defaultFonts?[style.rawValue] else {
            print("Font not found for style = \(style.rawValue)!")
            return UIFont.systemFont(ofSize: size, weight: .thin)
        }

        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }

}
