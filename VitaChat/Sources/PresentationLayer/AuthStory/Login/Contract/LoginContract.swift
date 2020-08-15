//
//  LoginContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 09.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol LoginBuilderProtocol: class {
    static func build() -> LoginViewController
}

// MARK: - View
protocol LoginViewInput: class {

     func setupScreen(with model: LoginViewModel)

}

protocol LoginViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol LoginInteractorInput {}
protocol LoginInteractorOutput: class {}

// MARK: - Router
protocol LoginRouterInput {}
