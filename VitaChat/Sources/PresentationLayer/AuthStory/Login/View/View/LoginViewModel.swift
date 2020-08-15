//
//  LoginViewModel.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 09.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

enum LoginContact: String {
    case email = "Введите Email"
    case passsword = "Введите пароль"
}

import UIKit

struct LoginViewModel {

    // MARK: - Properties
    let title: NSAttributedString
    let emailTitle: NSAttributedString
    let passwordTitle: NSAttributedString
    let textFieldAttributes: [NSAttributedString.Key : Any]
    let loginButtonTitle: NSAttributedString

    init() {
        let colorManager = DIContainer.colorManager
        let fontManager = DIContainer.fontManager

        title = "С возвращением!".addAttributes(fontStyle: .bold, size: 26, color: colorManager.n1)
        emailTitle = LoginContact.email.rawValue.addAttributes(fontStyle: .thin, size: 20, color: colorManager.n1)
        passwordTitle = LoginContact.passsword.rawValue.addAttributes(fontStyle: .thin, size: 20, color: colorManager.n1)

        textFieldAttributes = [.font: fontManager.getFont(for: .medium, ofSize: 15)]
        loginButtonTitle = "Войти".addAttributes(fontStyle: .medium, size: 20, color: colorManager.n14)
    }

}
