//
//  SignUpRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class SignUpRouter {

    // MARK: - Properties
    weak var view: UIViewController?
    private let bag = DisposeBag()

}

extension SignUpRouter: SignUpRouterInput {

    func navigateToProfileCreation(with context: ProfileContext) {
        let profileVC = ProfileBuilder.build(with: context)
        UIApplication.getTopViewController()?.present(profileVC, animated: true)
    }

    func showErrorAlert(title: String) {
        view?.showErrorAlert(labelText: "Ошибка", detailText: title)
    }

    func dismiss(with authModule: AuthModuleInput) {
        view?.dismiss(animated: true) {
            authModule.didTapHasExistingAccount()
        }
    }
}
