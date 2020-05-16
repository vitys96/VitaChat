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

    func navigateToProfile(with user: User) {
        let profileVC = ProfileBuilder.build(with: user)
        UIApplication.getTopViewController()?.present(profileVC, animated: true)
    }


    func navigateToMainTabBar(with user: AppUser) {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(tabBar, animated: true)
    }

}
