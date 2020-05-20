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

    // MARK: - Properties

    // MARK: - Init
    init(interactor: PeopleInteractorInput, router: PeopleRouterInput) {
        self.interactor = interactor
        self.router = router
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

    func viewDidLoad() {
        view?.reloadData(with: nil)
    }

}

// MARK: - PeopleInteractorOutput
extension PeoplePresenter: PeopleInteractorOutput {
    
}

