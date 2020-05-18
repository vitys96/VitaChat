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
    static func build() -> PeopleViewController
}

// MARK: - View
protocol PeopleViewInput: class {

     func showDataSource(data: NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>)

}

protocol PeopleViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol PeopleInteractorInput {}
protocol PeopleInteractorOutput: class {}

// MARK: - Router
protocol PeopleRouterInput {}
