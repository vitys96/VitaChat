//
//  ChatViewModel.swift
//  VitaChat
//
//  Created by Vitaly on 13.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

struct ChatViewModel: Hashable {
    
    // MARK: - Properties
    let userId: String
    let userName: String
    
    init(with model: AppUser) {
//        let colorManager = DIContainer.colorManager
        
        userId = model.id
        userName = model.username
    }
    
}

enum ChatCellType {

    case user(model: AppUser)
    case messages(models: [AppMessage])
    
}
