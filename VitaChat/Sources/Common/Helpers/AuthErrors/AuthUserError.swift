//
//  AuthUserError.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

enum AuthUserError {
    case notFilled
    case photoNotExist
    case cannotUnwrapToUser
    case cannotGetUserInfo
}

extension AuthUserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Невозможно загрузить информацию о User из Firebase", comment: "")
        case .cannotUnwrapToUser:
            return NSLocalizedString("Невозможно конвертировать AppUser из User", comment: "")
        }
    }
}
