//
//  NSObjectProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

extension NSObjectProtocol {

    func with(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

}
