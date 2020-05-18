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
    let activeChats = Bundle.main.decode([ConversationModelCell].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([ConversationModelCell].self, from: "waitingChats.json")

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ConversationsInteractorInput, router: ConversationsRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    private func makeViewModels() -> NSDiffableDataSourceSnapshot<Section, ConversationCellViewModel> {
        let waitingChatsViewModel = activeChats.map { ConversationCellViewModel(with: $0) }
        let activeChatsViewModel = waitingChats.map { ConversationCellViewModel(with: $0) }

        var snapshot = NSDiffableDataSourceSnapshot<Section, ConversationCellViewModel>()

        snapshot.appendSections([.activeChats, .waitingChats])

        snapshot.appendItems(waitingChatsViewModel, toSection: .waitingChats)
        snapshot.appendItems(activeChatsViewModel, toSection: .activeChats)

        return snapshot
    }

}

// MARK: - ConversationsViewOutput
extension ConversationsPresenter: ConversationsViewOutput {

    func viewDidLoad() {
        view?.showDataSource(data: makeViewModels())
    }
}

// MARK: - ConversationsInteractorOutput
extension ConversationsPresenter: ConversationsInteractorOutput {
    
}

