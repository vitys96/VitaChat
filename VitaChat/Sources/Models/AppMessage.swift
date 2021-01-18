//
//  AppMessage.swift
//  VitaChat
//
//  Created by Vitaly on 05.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct AppMessage: Hashable, MessageType {

    var sender: SenderType
    let content: String
    var sentDate: Date
    let id: String?
    
    var kind: MessageKind {
        return .text(content)
    }
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    init(user: AppUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        sender = Sender(senderId: senderId, displayName: senderName)
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.content = content
    }
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: AppMessage, rhs: AppMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }

}

extension AppMessage: Comparable {

    static func < (lhs: AppMessage, rhs: AppMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }

}
