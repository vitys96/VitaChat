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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: AppChat, rhs: AppChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }

}
