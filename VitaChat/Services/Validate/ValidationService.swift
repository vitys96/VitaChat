//
//  ValidationService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

final class ValidationService: ValidationServiceProtocol {


    func isValidUserName(_ name: String?) -> Bool {
        return name != nil && name?.count != 0
    }

    func isValidDescription(_ description: String?) -> Bool {
        return description != nil && description?.count != 0
    }

}
