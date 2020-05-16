//
//  FontManagerProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIFont

/**
 Протокол для сервиса шрифтов, все шрифты должны лежать в файле VitaFonts.plist
 */
protocol FontManagerProtocol {

    func getFont(for style: FontStyle, ofSize size: CGFloat) -> UIFont

}
