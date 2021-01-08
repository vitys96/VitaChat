//
//  ChatRequestPresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 20.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ChatRequestPresenter {

    // MARK: - Protocol properties
    weak var view: ChatRequestViewInput?
    private var interactor: ChatRequestInteractorInput
    private let router: ChatRequestRouterInput
    private let chat: AppChat

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ChatRequestInteractorInput, router: ChatRequestRouterInput, chat: AppChat) {
        self.interactor = interactor
        self.router = router
        self.chat = chat
    }

}

// MARK: - ChatRequestViewOutput
extension ChatRequestPresenter: ChatRequestViewOutput {

    func viewDidLoad() {
        view?.showRequestChatData(with: ChatRequestViewModel(with: chat))
    }

}

// MARK: - ChatRequestInteractorOutput
extension ChatRequestPresenter: ChatRequestInteractorOutput {
    
}

