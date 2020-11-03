//
//  UserSection.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.11.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

enum UsersSection: Int, CaseIterable {
    case users
    func desr(usersCount: Int) -> String {
        switch self {
        case .users:
            return String(format: "Рядом %@", String.pluralBy("NumberOfPeople", usersCount))
        }
    }
}
