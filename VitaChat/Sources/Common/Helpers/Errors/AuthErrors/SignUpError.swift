//
//  SignUpError.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

enum SignUpError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
    case canNotUploadPhoto
}

extension SignUpError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Формат почты не является допустимым", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        case .canNotUploadPhoto:
            return NSLocalizedString("Не удалось загрузить фото", comment: "")
        }
    }
}
