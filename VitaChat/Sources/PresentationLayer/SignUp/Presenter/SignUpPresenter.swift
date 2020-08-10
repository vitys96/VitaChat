//
//  SignUpPresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class SignUpPresenter {

    // MARK: - Protocol properties
    weak var view: SignUpViewInput?
    private var interactor: SignUpInteractorInput
    private let router: SignUpRouterInput
    private weak var authModule: AuthModuleInput?

    // MARK: - Properties

    // MARK: - Init
    init(interactor: SignUpInteractorInput, router: SignUpRouterInput, context: SignUpContext) {
        self.interactor = interactor
        self.router = router
        self.authModule = context.authModule
    }


}

// MARK: - SignUpViewOutput
extension SignUpPresenter: SignUpViewOutput {

    func didTapLoginButton() {
        guard let authModule = authModule else {
            return
        }
        router.dismiss(with: authModule)
    }

    func viewDidLoad() {
        view?.setupScreen(with: SignUpViewModel())
    }

}

// MARK: - SignUpInteractorOutput
extension SignUpPresenter: SignUpInteractorOutput {
    
}

