//
//  AppChat.swift
//  VitaChat
//
//  Created by Vitaly on 05.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct AppChat: Hashable, Decodable {

    let friendUsername: String
    let friendAvatarStringURL: String
    let lastMessageContent: String
    let friendId: String
    
    var representation: [String : Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["friendId"] = friendId
        rep["lastMessage"] = lastMessageContent
        return rep
    }
    
    init(friendUsername: String, friendAvatarStringURL: String, friendId: String, lastMessageContent: String) {
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUsername = data["friendUsername"] as? String,
        let friendAvatarStringURL = data["friendAvatarStringURL"] as? String,
        let friendId = data["friendId"] as? String,
        let lastMessageContent = data["lastMessage"] as? String else {
            return nil
        }
        
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.friendId = friendId
        self.lastMessageContent = lastMessageContent
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: AppChat, rhs: AppChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }

}
