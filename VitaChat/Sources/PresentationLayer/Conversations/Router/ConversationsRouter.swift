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

    func navigateToChatRequestScreen(with chat: AppChat) {
        let vc = ChatRequestBuilder.build(with: chat)
        view?.present(vc, animated: true)
    }

}
