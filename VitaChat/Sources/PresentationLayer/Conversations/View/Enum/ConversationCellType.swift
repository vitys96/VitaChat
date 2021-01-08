//
//  ConversationCellType.swift
//  VitaChat
//
//  Created by Vitaly on 08.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

enum ConversationCellType: Int, CaseIterable {

    case waitingChats
    case activeChats
    
}

extension ConversationCellType {
    
    func description() -> String {
        switch self {
        case .waitingChats:
            return "В ожидании"
        case .activeChats:
            return "Активные чаты"
        }
    }
    
}
