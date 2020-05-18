//
//  PeopleViewModel.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

struct PeopleViewModel: Hashable {

    // MARK: - Properties
    let id: Int
    let username: NSAttributedString
    let userImageString: String

    init(with model: PeopleModelCell) {
        let colorManager = DIContainer.colorManager

        id = model.id
        username = model.username.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        userImageString = model.avatarStringURL
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
