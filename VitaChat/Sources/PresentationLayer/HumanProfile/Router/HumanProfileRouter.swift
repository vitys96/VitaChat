//
//  HumanProfileRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class HumanProfileRouter {

    // MARK: - Properties
    weak var view: UIViewController?

}

extension HumanProfileRouter: HumanProfileRouterInput {

    func dismiss() {
        view?.dismiss(animated: true)
    }

    func showErrorAlert(title: String) {
        view?.showErrorAlert(labelText: "Ошибка", detailText: title)
    }

}
