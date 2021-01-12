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
    private var users = [AppUser]()

    // MARK: - Init
    init(interactor: PeopleInteractorInput, router: PeopleRouterInput, currentUser: AppUser) {
        self.interactor = interactor
        self.router = router
        self.currentUser = currentUser
    }

    private func makeViewModels(users: [AppUser]) -> NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel> {
        let usersModel = users.map { PeopleViewModel(with: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>()
        snapshot.appendSections([.users])
        snapshot.appendItems(usersModel, toSection: .users)

        return snapshot
    }

}

// MARK: - PeopleViewOutput
extension PeoplePresenter: PeopleViewOutput {

    func didSelectUser(user: PeopleViewModel) {
        guard let user = self.users.first(where: { $0.id == user.id }) else {
            return
        }
        router.navigateToHumanProfile(with: user)
    }

    func didTapLogOutButton() {
        router.showLogOutAlert { [unowned self] isNeedtoLogOut in
            if isNeedtoLogOut {
                self.view?.startLoadingAnimation()
                self.interactor.logOutUser()
            }
        }
    }

    func viewDidLoad() {
        interactor.fetchUsersData(with: users, userId: currentUser.id)
        view?.reloadData(with: nil)
    }

}

// MARK: - PeopleInteractorOutput
extension PeoplePresenter: PeopleInteractorOutput {

    func usersDidFetched(users: [AppUser]) {
        self.users = users
        view?.showDataSource(data: makeViewModels(users: users))
    }

    func userDidLogOut() {
        view?.stopLoadingAnimation()
        router.navigateToAuth()
    }

}

