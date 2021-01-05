//
//  AppMessage.swift
//  VitaChat
//
//  Created by Vitaly on 05.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

struct AppMessage: Hashable {
   
    let content: String
    var senderId: String
    var senderUsername: String
    var sentDate: Date
    let id: String?
    
    init(user: AppUser, content: String) {
        self.content = content
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
    }
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderID": senderId,
            "senderName": senderUsername,
            "content": content
        ]
        return rep
    }

}
