//
//  SignUpContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol SignUpBuilderProtocol: class {
    static func build() -> SignUpViewController
}

// MARK: - View
protocol SignUpViewInput: class {}

protocol SignUpViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol SignUpInteractorInput {}
protocol SignUpInteractorOutput: class {}

// MARK: - Router
protocol SignUpRouterInput {}
