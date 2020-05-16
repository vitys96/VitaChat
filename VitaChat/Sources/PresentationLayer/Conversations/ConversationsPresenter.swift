//
//  ConversationsPresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ConversationsPresenter {

    // MARK: - Protocol properties
    weak var view: ConversationsViewInput?
    private var interactor: ConversationsInteractorInput
    private let router: ConversationsRouterInput

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ConversationsInteractorInput, router: ConversationsRouterInput) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - ConversationsViewOutput
extension ConversationsPresenter: ConversationsViewOutput {
    func viewDidLoad() {}
}

// MARK: - ConversationsInteractorOutput
extension ConversationsPresenter: ConversationsInteractorOutput {
    
}

