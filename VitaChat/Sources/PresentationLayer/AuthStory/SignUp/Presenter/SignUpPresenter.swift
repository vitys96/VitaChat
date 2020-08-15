//
//  SignUpPresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseAuth
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

    func didTapRegisterUser(email: String?, password: String?, confirmPassword: String?) {
        let signUpContactModel = SignUpContacts(email: email, password: password, confirmPassword: confirmPassword)
        interactor.registerUser(with: signUpContactModel)
    }

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

    func errorFetched(error: Error) {
        router.showErrorAlert(title: error.localizedDescription)
    }

    func userFetched(user: User) {
        let profileContext = ProfileContext(uid: user.uid, email: user.email)
        router.navigateToProfileCreation(with: profileContext)
    }
    
}

