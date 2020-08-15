//
//  ProfileRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ProfileRouter {

    // MARK: - Properties
    weak var view: UIViewController?

}

extension ProfileRouter: ProfileRouterInput {

    func showErrorAlert(title: String) {
        view?.showErrorAlert(labelText: "Ошибка", detailText: title)
    }

    func navigateToMainScreen(with user: AppUser) {
        let tabBarControoler = TabBarController(currentUser: user)
        tabBarControoler.configure(screens: [
            (.conversations, ConversationsBuilder.build())
        ])
        tabBarControoler.modalPresentationStyle = .fullScreen
        view?.present(tabBarControoler, animated: true)

    }
}
