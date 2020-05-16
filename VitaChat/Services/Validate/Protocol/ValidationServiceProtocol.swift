//
//  ValidationServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

protocol ValidationServiceProtocol {

    func isValidUserName(_ name: String?) -> Bool

    func isValidDescription(_ description: String?) -> Bool

}
