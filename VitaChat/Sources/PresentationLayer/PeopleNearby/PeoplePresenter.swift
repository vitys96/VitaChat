//
//  PeoplePresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class PeoplePresenter {

    // MARK: - Protocol properties
    weak var view: PeopleViewInput?
    private var interactor: PeopleInteractorInput
    private let router: PeopleRouterInput
    private let currentUser: AppUser

    // MARK: - Properties

    // MARK: - Init
    init(interactor: PeopleInteractorInput, router: PeopleRouterInput, currentUser: AppUser) {
        self.interactor = interactor
        self.router = router
        self.currentUser = currentUser
    }

//    private func makeViewModels() -> NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel> {
//        let usersViewModel = activeChats.map { PeopleViewModel(with: $0) }
//
//        var snapshot = NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>()
//
//        snapshot.appendSections([.users])
//
//        snapshot.appendItems(usersViewModel, toSection: .users)
//
//        return snapshot
//    }

}

// MARK: - PeopleViewOutput
extension PeoplePresenter: PeopleViewOutput {

    func didTapLogOutButton() {
        router.showLogOutAlert { [unowned self] isNeedtoLogOut in
            if isNeedtoLogOut {
                self.view?.startLoadingAnimation()
                self.interactor.logOutUser()
            }
        }
    }

    func viewDidLoad() {
        view?.reloadData(with: nil)
    }

}

// MARK: - PeopleInteractorOutput
extension PeoplePresenter: PeopleInteractorOutput {

    func userDidLogOut() {
        view?.stopLoadingAnimation()
        router.navigateToAuth()
    }

}

