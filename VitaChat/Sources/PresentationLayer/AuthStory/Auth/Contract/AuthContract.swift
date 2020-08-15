//
//  AuthContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import GoogleSignIn
import Firebase
import UIKit

// MARK: - Builder
protocol AuthBuilderProtocol: class {
    static func build() -> AuthViewController
}

// MARK: - View
protocol AuthViewInput: class {

    func startLoadingAnimation()

    func stopLoadingAnimation()

    func showData()

}

protocol AuthViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()

    func didSigned(user: GIDGoogleUser, withError error: Error?)

    func didTapLoginButton()

    func didTapSignUpButton()

}

// MARK: - Interactor
protocol AuthInteractorInput {

    func userAuthByGoogle(user: GIDGoogleUser, withError error: Error?)

}
protocol AuthInteractorOutput: class {

    func userDidExistInDB(user: AppUser)
    func userDidNotExistInDB(user: User)
}

// MARK: - Router
protocol AuthRouterInput {

    func navigateToMainTabBar(with user: AppUser)

    func navigateToProfile(with context: ProfileContext)

    func navigateToLoginScreen()

    func navigateToSignUpScreen(with context: SignUpContext)

}

// MARK: - Input
protocol AuthModuleInput: class {

    func didTapHasExistingAccount()

}