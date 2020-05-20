//
//  ChatRequestContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 20.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol ChatRequestBuilderProtocol: class {
    static func build() -> ChatRequestViewController
}

// MARK: - View
protocol ChatRequestViewInput: class {}

protocol ChatRequestViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol ChatRequestInteractorInput {}
protocol ChatRequestInteractorOutput: class {}

// MARK: - Router
protocol ChatRequestRouterInput {}
