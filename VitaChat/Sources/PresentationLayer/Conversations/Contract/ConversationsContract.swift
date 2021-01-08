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
    
    func showDataSource(snapshot: NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel>)
    func configureView(navigationTitle: String)
}

protocol ConversationsViewOutput {
    /**
     Метод сообщающий, что view была загружена
     */
    func viewDidLoad()
}

// MARK: - Interactor
protocol ConversationsInteractorInput {
    /**
     Метод для запроса чатов
     */
    func fetchChats(with chats: [AppChat])
}
protocol ConversationsInteractorOutput: class {
    /**
     Метод сообщающий, что список чатов был получен
     */
    func chatsDidFetched(chats: [AppChat])
}

// MARK: - Router
protocol ConversationsRouterInput {
    /**
     Метод сообщающий, что необходимо показать экран "Запроса чата"
     */
    func navigateToChatRequestScreen(with chat: AppChat)
}
