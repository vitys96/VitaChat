//
//  PeopleRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import RxSwift

final class PeopleRouter {

    // MARK: - Properties
    weak var view: UIViewController?
    private let disposeBag = DisposeBag()

}

extension PeopleRouter: PeopleRouterInput {

    func navigateToHumanProfile(with user: AppUser) {
        let viewController = HumanProfileBuilder.build(with: user)
        view?.present(viewController, animated: true)
    }

    func navigateToAuth() {
        let authViewControoler = AuthBuilder.build()
        authViewControoler.modalPresentationStyle = .fullScreen
        view?.present(authViewControoler, animated: true)
    }

    func showLogOutAlert(destructiveHandler: @escaping (Bool) -> Void) {
        view?.showAlert(title: "Вы точно хотите выйти?", message: nil, style: .alert, actions: [
            AlertAction.action(title: "Нет", style: .cancel),
            AlertAction.action(title: "Да", style: .destructive)
        ])
            .subscribe(onNext: { selectedIndex in
                if selectedIndex == 1 {
                    destructiveHandler(true)
                }
        })
        .disposed(by: disposeBag)
    }

}
