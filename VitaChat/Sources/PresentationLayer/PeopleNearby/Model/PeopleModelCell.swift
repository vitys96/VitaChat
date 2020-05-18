//
//  PeopleModelCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

struct PeopleModelCell: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PeopleModelCell, rhs: PeopleModelCell) -> Bool {
        return lhs.id == rhs.id
    }
}
