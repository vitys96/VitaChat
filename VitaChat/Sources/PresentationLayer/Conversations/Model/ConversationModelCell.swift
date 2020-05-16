//
//  ConversationModelCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

struct ConversationModelCell: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ConversationModelCell, rhs: ConversationModelCell) -> Bool {
        return lhs.id == rhs.id
    }
}

