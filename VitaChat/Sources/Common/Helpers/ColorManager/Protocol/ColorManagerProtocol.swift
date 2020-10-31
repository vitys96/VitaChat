//
//  ColorManagerProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIColor

public protocol ColorManagerProtocol {

    /** Цветовая палитра приложения */
    var n1: UIColor { get }
    var n2: UIColor { get }
    var n3: UIColor { get }
    var n4: UIColor { get }
    var n5: UIColor { get }
    var n6: UIColor { get }
    var n7: UIColor { get }
    var n8: UIColor { get }
    var n9: UIColor { get }
    var n10: UIColor { get }
    var n11: UIColor { get }
    var n12: UIColor { get }
    var n13: UIColor { get }
    var n14: UIColor { get }
    var n15: UIColor { get }
    var staticWhite: UIColor { get }    // Неинвертируемый белый цвет
    var staticBlack: UIColor { get }    // Неинвертируемый черный цвет
    var tabBar: UIColor { get }

    /** Установка цветов палитры */
    func setup(
        n1: UIColor?,
        n2: UIColor?,
        n3: UIColor?,
        n4: UIColor?,
        n5: UIColor?,
        n6: UIColor?,
        n7: UIColor?,
        n8: UIColor?,
        n9: UIColor?,
        n10: UIColor?,
        n11: UIColor?,
        n12: UIColor?,
        n13: UIColor?,
        n14: UIColor?,
        n15: UIColor?,
        staticWhite: UIColor?,
        staticBlack: UIColor?,
        tabBar: UIColor?)

}
