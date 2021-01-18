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
    private var activeChats = [AppChat]()
    
    // MARK: - Init
    init(interactor: ConversationsInteractorInput, router: ConversationsRouterInput, currentUser: AppUser) {
        self.interactor = interactor
        self.router = router
        self.currentUser = currentUser
    }
    
    private func makeViewModels(with waitingChats: [AppChat]) -> NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel> {
        let waitingChatsViewModel = waitingChats.map { ConversationCellViewModel(with: $0) }
        let activeChatsViewModel = activeChats.map { ConversationCellViewModel(with: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel>()
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChatsViewModel, toSection: .waitingChats)
        snapshot.appendItems(activeChatsViewModel, toSection: .activeChats)
        
        return snapshot
    }
    
    private func navigateToChatRequestScreen(with chat: AppChat) {
        let context = ChatRequestContext(chat: chat, conversationModule: self)
        router.navigateToChatRequestScreen(with: context)
    }
    
}

// MARK: - ConversationsViewOutput
extension ConversationsPresenter: ConversationsViewOutput {

    func didTapActiveChat(with model: ConversationCellViewModel) {
//        guard let chat = waitingChats.first(where: { $0.friendId == model.id }) else {
//            return
//        }
        router.navigateToChat(with: currentUser)
    }
    
    func didTapWaitingChat(with model: ConversationCellViewModel) {
        guard let chat = waitingChats.first(where: { $0.friendId == model.id }) else {
            return
        }
        navigateToChatRequestScreen(with: chat)
    }
    
    func viewDidLoad() {
        interactor.fetchChats(with: [])
        view?.configureView(navigationTitle: currentUser.username)
    }
}

// MARK: - ConversationsInteractorOutput
extension ConversationsPresenter: ConversationsInteractorOutput {
    
    func performSuccess() {
        view?.stopLoadingAnimation()
    }
    
    func chatsDidFetched(chats: [AppChat], isWaitingChat: Bool) {
        if isWaitingChat {
            if !waitingChats.isEmpty && waitingChats.count < chats.count {
                guard let lastChat = chats.last else {
                    return
                }
                navigateToChatRequestScreen(with: lastChat)
            }
            waitingChats = chats
        } else {
            activeChats = chats
        }
        view?.showDataSource(snapshot: makeViewModels(with: chats))
    }
    
}

// MARK: - ConversationsModuleInput
extension ConversationsPresenter: ConversationsModuleInput {

    func didTapAddWaitingChat(_ chat: AppChat) {
        view?.startLoadingAnimation()
        interactor.addWaitingChat(chat)
    }

    func didTapRemoveWaitingChat(_ chat: AppChat) {
        view?.startLoadingAnimation()
        interactor.removeWaitingChat(chat)
    }
    
}
