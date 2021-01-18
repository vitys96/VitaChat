//
//  ChatsContract.swift
//  VitaChat
//
//  Created Vitaly on 13.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol ChatsBuilderProtocol: class {
    static func build(with user: AppUser) -> ChatsViewController
}

// MARK: - View
protocol ChatsViewInput: class {}

protocol ChatsViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol ChatsInteractorInput {}
protocol ChatsInteractorOutput: class {}

// MARK: - Router
protocol ChatsRouterInput {}
