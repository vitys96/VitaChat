//
//  AppMessage.swift
//  VitaChat
//
//  Created by Vitaly on 05.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderId = senderId
        self.senderUsername = senderName
        self.content = content
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
