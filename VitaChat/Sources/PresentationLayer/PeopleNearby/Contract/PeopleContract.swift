//
//  PeopleContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol PeopleBuilderProtocol: class {
    static func build(with currentUser: AppUser) -> PeopleViewController
}

// MARK: - View
protocol PeopleViewInput: class {

    func startLoadingAnimation()

    func stopLoadingAnimation()

    func reloadData(with searchText: String?)

    func showDataSource(data: NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>)

}

protocol PeopleViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
    /**
      Метод сообщающий, что кнопка log out была нажата
    */
    func didTapLogOutButton()
    /**
      Метод сообщающий, что нажали на кого-либо юзера
    */
    func didSelectUser(user: PeopleViewModel)

}

// MARK: - Interactor
protocol PeopleInteractorInput {

    func logOutUser()

    func fetchUsersData(with users: [AppUser], userId: String)

}
protocol PeopleInteractorOutput: class {

    func userDidLogOut()
    func usersDidFetched(users: [AppUser])
}

// MARK: - Router
protocol PeopleRouterInput {

    func showLogOutAlert(destructiveHandler: @escaping (Bool) -> Void)
    /**
      Переход на экран авторизации
    */
    func navigateToAuth()
    /**
      Переход на экран конкретного юзера
    */
    func navigateToHumanProfile(with user: AppUser)
}
