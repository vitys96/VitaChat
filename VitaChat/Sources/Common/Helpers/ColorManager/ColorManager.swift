//
//  ColorManager.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIColor

final class ColorManager: ColorManagerProtocol {

    // MARK: - Protocol properties
    static var shared: ColorManagerProtocol = ColorManager()

    // MARK: - Init
    private init() {}

    // MARK: - Properties
    private(set) var n1 = UIColor(hex: "#FFFFFF")
    private(set) var n2 = UIColor(hex: "#007AFF")
    private(set) var n3 = UIColor(hex: "#04AA11")
    private(set) var n4 = UIColor(hex: "#F7CA18")
    private(set) var n5 = UIColor(hex: "#FF7543")
    private(set) var n6 = UIColor(hex: "#FC314A")
    private(set) var n7 = UIColor(hex: "#FE373F")
    private(set) var n8 = UIColor(hex: "#FF0009")
    private(set) var n9 = UIColor(hex: "#F4CB7E")
    private(set) var n10 = UIColor(hex: "#C1A062")
    private(set) var n11 = UIColor(hex: "#1B1B1D")
    private(set) var n12 = UIColor(hex: "#707476")
    private(set) var n13 = UIColor(hex: "#242424")
    private(set) var n14 = UIColor(hex: "#000000")
    private(set) var n15 = UIColor(hex: "#2C2C2E")
    private(set) var staticWhite = UIColor(hex: "#FFFFFF")
    private(set) var staticBlack = UIColor(hex: "#000000")
    private(set) var tabBar = UIColor(hex: "#8E5AF7")

    // MARK: - Public methods
    func setup(
        n1: UIColor?, n2: UIColor?, n3: UIColor?, n4: UIColor?, n5: UIColor?, n6: UIColor?, n7: UIColor?,
        n8: UIColor?, n9: UIColor?, n10: UIColor?, n11: UIColor?, n12: UIColor?, n13: UIColor?, n14: UIColor?, n15: UIColor?,
        staticWhite: UIColor?, staticBlack: UIColor?, tabBar: UIColor?) {
        n1.map { self.n1 = $0 }
        n2.map { self.n2 = $0 }
        n3.map { self.n3 = $0 }
        n4.map { self.n4 = $0 }
        n5.map { self.n5 = $0 }
        n6.map { self.n6 = $0 }
        n7.map { self.n7 = $0 }
        n8.map { self.n8 = $0 }
        n9.map { self.n9 = $0 }
        n10.map { self.n10 = $0 }
        n11.map { self.n11 = $0 }
        n12.map { self.n12 = $0 }
        n13.map { self.n13 = $0 }
        n14.map { self.n14 = $0 }
        n15.map { self.n15 = $0 }
        staticWhite.map { self.staticWhite = $0 }
        staticBlack.map { self.staticBlack = $0 }
        tabBar.map { self.tabBar = $0 } 

    }

}

