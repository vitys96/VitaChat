//
//  HumanProfileContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol HumanProfileBuilderProtocol: class {
    static func build(with context: HumanProfileContext) -> HumanProfileViewController
}

// MARK: - View
protocol HumanProfileViewInput: class {}

protocol HumanProfileViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol HumanProfileInteractorInput {}
protocol HumanProfileInteractorOutput: class {}

// MARK: - Router
protocol HumanProfileRouterInput {}
