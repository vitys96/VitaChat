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
    let id: String
    let username: NSAttributedString
    let userImageUrl: URL?
    
    init(with model: AppUser) {
        let colorManager = DIContainer.colorManager
        
        id = model.id
        username = model.username.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        userImageUrl = URL(string: model.avatarStringURL)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func containsText(filterText: String?) -> Bool {
        guard let filter = filterText else { return true }
        if filter.isEmpty {
            return true
        }
        let lowercasedFilter = filter.lowercased()
        return username.string.lowercased().contains(lowercasedFilter)
    }
    
}
