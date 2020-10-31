//
//  String+Localizable.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 31.10.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

extension String {

    static func pluralBy(_ format: String, _ arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(format, tableName: nil, bundle: Bundle.main, value: "", comment: ""),
                      locale: Locale(identifier: "ru"), arguments: arguments)
    }

}
