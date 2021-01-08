//
//  ChatRequestViewModel.swift
//  VitaChat
//
//  Created by Vitaly on 08.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//
import UIKit

struct ChatRequestViewModel {

    // MARK: - Properties
    let id: String
    let username: NSAttributedString
    let userImageUrl: URL?
//    let lastMessage: NSAttributedString

    init(with model: AppChat) {
        let colorManager = DIContainer.colorManager

        id = model.friendId
        username = model.friendUsername.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        userImageUrl = URL(string: model.friendAvatarStringURL)
//        lastMessage = model.lastMessage.addAttributes(fontStyle: .thin, size: 15, color: colorManager.n1)
    }

}
