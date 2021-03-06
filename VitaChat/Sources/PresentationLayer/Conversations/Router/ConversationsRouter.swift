//
//  ConversationsRouter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ConversationsRouter {

    // MARK: - Properties
    weak var view: UIViewController?

}

extension ConversationsRouter: ConversationsRouterInput {

    func navigateToChat(with chat: AppUser) {
        let chatViewController = ChatsBuilder.build(with: chat)
        chatViewController.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(chatViewController, animated: true)
    }

    func navigateToChatRequestScreen(with context: ChatRequestContext) {
        let chatRequestViewController = ChatRequestBuilder.build(with: context)
        view?.present(chatRequestViewController, animated: true)
    }

}
