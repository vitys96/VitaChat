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
    let id: Int
    let username: NSAttributedString
    let userImageString: String
    let lastMessage: NSAttributedString

    init(with model: ConversationModelCell) {
        let colorManager = DIContainer.colorManager

        id = model.id
        username = model.username.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        userImageString = model.userImageString
        lastMessage = model.lastMessage.addAttributes(fontStyle: .thin, size: 15, color: colorManager.n1)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
