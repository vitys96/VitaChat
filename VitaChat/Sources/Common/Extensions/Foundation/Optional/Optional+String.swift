//
//  Optional+String.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 24.10.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    var asURL: URL? {
        return self
            .flatMap { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) }
            .flatMap { URL(string: $0) }
    }

}
