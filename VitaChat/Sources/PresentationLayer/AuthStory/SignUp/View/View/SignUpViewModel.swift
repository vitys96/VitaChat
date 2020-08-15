//
//  SignUpViewModel.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 23.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//
enum SignUpContact: String {
    case email = "Введите Email"
    case passsword = "Придумайте пароль"
    case confirmPassword = "Подтвердите пароль"
}

import UIKit

struct SignUpViewModel {

    // MARK: - Properties
    let title: NSAttributedString
    let emailTitle: NSAttributedString
    let passwordTitle: NSAttributedString
    let confirmPasswordTitle: NSAttributedString
    let textFieldAttributes: [NSAttributedString.Key : Any]
    let loginButtonTitle: NSAttributedString

    init() {
        let colorManager = DIContainer.colorManager
        let fontManager = DIContainer.fontManager

        title = "Приветствуем!".addAttributes(fontStyle: .bold, size: 26, color: colorManager.n1)
        emailTitle = SignUpContact.email.rawValue.addAttributes(fontStyle: .thin, size: 20, color: colorManager.n1)
        passwordTitle = SignUpContact.passsword.rawValue.addAttributes(fontStyle: .thin, size: 20, color: colorManager.n1)
        confirmPasswordTitle = SignUpContact.confirmPassword.rawValue.addAttributes(fontStyle: .thin, size: 20, color: colorManager.n1)

        textFieldAttributes = [.font: fontManager.getFont(for: .medium, ofSize: 15)]
        loginButtonTitle = "Войти в существующий аккаунт".addAttributesForPreffereddFont(fontStyle: .body, color: colorManager.n6)
    }

}
