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
    private let currentUser: AppUser
    private var waitingChats = [AppChat]()
    
    // MARK: - Init
    init(interactor: ConversationsInteractorInput, router: ConversationsRouterInput, currentUser: AppUser) {
        self.interactor = interactor
        self.router = router
        self.currentUser = currentUser
    }
    
    private func makeViewModels(with waitingChats: [AppChat]) -> NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel> {
        let waitingChatsViewModel = waitingChats.map { ConversationCellViewModel(with: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel>()
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChatsViewModel, toSection: .waitingChats)
        
        return snapshot
    }
    
}

// MARK: - ConversationsViewOutput
extension ConversationsPresenter: ConversationsViewOutput {
    
    func viewDidLoad() {
//        router.navigateToChatRequestScreen()
        interactor.fetchChats(with: [])
        view?.configureView(navigationTitle: currentUser.username)
    }
}

// MARK: - ConversationsInteractorOutput
extension ConversationsPresenter: ConversationsInteractorOutput {
    
    func chatsDidFetched(chats: [AppChat]) {
        if !waitingChats.isEmpty && waitingChats.count < chats.count {
            guard let lastChat = chats.last else {
                return
            }
            router.navigateToChatRequestScreen(with: lastChat)
        }
        waitingChats = chats
        view?.showDataSource(snapshot: makeViewModels(with: chats))
    }
    
}
