//
//  AuthRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import Firebase

final class AuthRouter {

    // MARK: - Properties
    weak var view: UIViewController?

}

extension AuthRouter: AuthRouterInput {

    func showErrorAlert(title: String) {
        view?.showErrorAlert(labelText: "Ошибка", detailText: title)
    }

    func navigateToSignUpScreen(with context: SignUpContext) {
        let loginVC = SignUpBuilder.build(with: context)
        view?.present(loginVC, animated: true)
    }

    func navigateToLoginScreen() {
        let loginVC = LoginBuilder.build()
        view?.present(loginVC, animated: true)
    }

    func navigateToProfile(with context: ProfileContext) {
        let profileVC = ProfileBuilder.build(with: context)
        UIApplication.getTopViewController()?.present(profileVC, animated: true)
    }


    func navigateToMainTabBar(with user: AppUser) {
        let tabBarControoler = TabBarController()
        tabBarControoler.configure(screens: [
            (.conversations, ConversationsBuilder.build(with: user)),
            (.people, PeopleBuilder.build(with: user))
        ])
        tabBarControoler.modalPresentationStyle = .fullScreen
        view?.present(tabBarControoler, animated: true)
    }

}
