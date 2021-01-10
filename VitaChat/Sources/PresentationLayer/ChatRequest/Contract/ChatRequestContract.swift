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
    static func build(with context: ChatRequestContext) -> ChatRequestViewController
}

// MARK: - View
protocol ChatRequestViewInput: class {
    func showRequestChatData(with model: ChatRequestViewModel)
}

protocol ChatRequestViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()
    /**
      Метод сообщающий, что была нажата кнопка отклонить
    */
     func didTapDenyButton()
    /**
      Метод сообщающий, что была нажата кнопка принять
    */
     func didTapAcceptButton()
}

// MARK: - Interactor
protocol ChatRequestInteractorInput {}
protocol ChatRequestInteractorOutput: class {}

// MARK: - Router
protocol ChatRequestRouterInput {}
