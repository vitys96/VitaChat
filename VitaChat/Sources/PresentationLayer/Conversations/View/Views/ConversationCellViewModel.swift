//
//  ConversationCellViewModel.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 16.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

struct ConversationCellViewModel: Hashable {

    // MARK: - Properties
    let id: String
//    let username: NSAttributedString
    let userImageUrl: URL?
//    let lastMessage: NSAttributedString

    init(with model: AppChat) {
//        let colorManager = DIContainer.colorManager

        id = model.friendId
//        username = model.username.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        userImageUrl = URL(string: model.friendAvatarStringURL)
//        lastMessage = model.lastMessage.addAttributes(fontStyle: .thin, size: 15, color: colorManager.n1)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
