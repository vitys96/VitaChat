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
    static func build(with user: AppUser) -> ConversationsViewController
}

// MARK: - View
protocol ConversationsViewInput: class {
    
    func startLoadingAnimation()

    func stopLoadingAnimation()
    
    func showDataSource(snapshot: NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel>)
    func configureView(navigationTitle: String)
}

protocol ConversationsViewOutput {
    /**
     Метод сообщающий, что view была загружена
     */
    func viewDidLoad()
    /**
     Метод сообщающий, что был нажат какой либо ожидающий чат
     */
    func didTapWaitingChat(with model: ConversationCellViewModel)
    /**
     Метод сообщающий, что был нажат какой либо активный чат
     */
    func didTapActiveChat(with model: ConversationCellViewModel)
}

// MARK: - Interactor
protocol ConversationsInteractorInput {
    /**
     Метод для запроса чатов
     */
    func fetchChats(with chats: [AppChat])
    /**
     Удалить чат, который ожидает подтверждения
     */
    func removeWaitingChat(_ chat: AppChat)
    /**
     Добавить чат, который ожидает подтверждения
     */
    func addWaitingChat(_ chat: AppChat)
}
protocol ConversationsInteractorOutput: class {
    /**
     Метод сообщающий, что список чатов был получен
     - pharams: isWaitingChat - зафечены ли isWaitingChat
     */
    func chatsDidFetched(chats: [AppChat], isWaitingChat: Bool)
    /**
     Метод сообщающий, что все получилось)
     */
    func performSuccess()
}

// MARK: - Router
protocol ConversationsRouterInput {
    /**
     Метод сообщающий, что необходимо показать экран "Запроса чата"
     */
    func navigateToChatRequestScreen(with context: ChatRequestContext)
    /**
     Метод сообщающий о переходе на экран чата
     */
    func navigateToChat(with chat: AppUser)
}

// MARK: - Input
protocol ConversationsModuleInput: class {
    /**
     Удалить чат, который ожидает подтверждения
     */
    func didTapRemoveWaitingChat(_ chat: AppChat)
    /**
     Добавить чат, который ожидает подтверждения
     */
    func didTapAddWaitingChat(_ chat: AppChat)
}
