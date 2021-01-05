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
    static func build(with user: AppUser) -> HumanProfileViewController
}

// MARK: - View
protocol HumanProfileViewInput: class {
    func startLoadingAnimation()

    func stopLoadingAnimation()
    /**
     Метод для передачи вью модели на слой view
     */
    func showData(with model: HumanProfileViewModel)
}

protocol HumanProfileViewOutput {
    /**
     Метод сообщающий, что view была загружена
     */
    func viewDidLoad()
    /**
     Метод сообщающий, что юзер отправил сообщение
     */
    func didTapSendMesssage(message: String)
}

// MARK: - Interactor
protocol HumanProfileInteractorInput {
    /**
     Метод для создания запроса на чат
     */
    func createWaitingChat(user: AppUser, message: String)
}
protocol HumanProfileInteractorOutput: class {
    /**
     Метод сообщающий, что запрос на чат был успешно отправлен
     */
    func chatRequestFetchedSuccessfully()
    /**
     Метод сообщающий, что запрос на чат был завершен с ошибкой
     */
    func chatRequestFetched(with error: Error)
}

// MARK: - Router
protocol HumanProfileRouterInput {
    func showErrorAlert(title: String)
    /**
    Закрыть модуль
    */
    func dismiss()
}
