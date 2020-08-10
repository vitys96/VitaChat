//
//  SignUpRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class SignUpRouter {

    // MARK: - Properties
    weak var view: UIViewController?

}

extension SignUpRouter: SignUpRouterInput {

    func dismiss(with authModule: AuthModuleInput) {
        view?.dismiss(animated: true) {
            authModule.didTapHasExistingAccount()
        }
    }
}
