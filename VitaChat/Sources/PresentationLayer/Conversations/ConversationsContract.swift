//
//  ConversationsContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

// MARK: - Builder
protocol ConversationsBuilderProtocol: class {
    static func build() -> ConversationsViewController
}

// MARK: - View
protocol ConversationsViewInput: class {

    func showDataSource(data: NSDiffableDataSourceSnapshot<Section, ConversationCellViewModel>)

}

protocol ConversationsViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
}

// MARK: - Interactor
protocol ConversationsInteractorInput {}
protocol ConversationsInteractorOutput: class {}

// MARK: - Router
protocol ConversationsRouterInput {}
