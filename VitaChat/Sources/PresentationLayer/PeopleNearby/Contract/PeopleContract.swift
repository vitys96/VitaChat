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

}

protocol PeopleViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()

    func didTapLogOutButton()
}

// MARK: - Interactor
protocol PeopleInteractorInput {

    func logOutUser()

}
protocol PeopleInteractorOutput: class {

    func userDidLogOut()
}

// MARK: - Router
protocol PeopleRouterInput {

    func showLogOutAlert(destructiveHandler: @escaping (Bool) -> Void)

    func navigateToAuth()
}
