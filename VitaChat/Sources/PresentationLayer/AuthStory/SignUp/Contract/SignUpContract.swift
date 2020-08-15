//
//  SignUpContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

// MARK: - Builder
protocol SignUpBuilderProtocol: class {
    static func build(with context: SignUpContext) -> SignUpViewController
}

// MARK: - View
protocol SignUpViewInput: class {

    func setupScreen(with model: SignUpViewModel)
    
}

protocol SignUpViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()

    func didTapLoginButton()

    func didTapRegisterUser(email: String?, password: String?, confirmPassword: String?)
}

// MARK: - Interactor
protocol SignUpInteractorInput {

    func registerUser(with contacts: SignUpContacts)

}
protocol SignUpInteractorOutput: class {

    func errorFetched(error: Error)

    func userFetched(user: User)
}

// MARK: - Router
protocol SignUpRouterInput {

    func dismiss(with authModule: AuthModuleInput)

    func showErrorAlert(title: String)

    func navigateToProfileCreation(with context: ProfileContext)

}
