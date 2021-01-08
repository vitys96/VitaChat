//
//  ListenerService.swift
//  VitaChat
//
//  Created by Vitaly on 06.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import RxSwift

class ListenerService: ListenerServiceProtocol {

    private let db = Firestore.firestore()
    
    private var currentUserId: String? {
        if let currnetUser = Auth.auth().currentUser {
            return currnetUser.uid
        }
        return nil
    }
    
    func waitingChatsObserve(chats: [AppChat], completion: @escaping ([AppChat]) -> Void) -> Single<ListenerRegistration> {
        return Single<ListenerRegistration>.create { single in
            guard let currentUserId = self.currentUserId else {
                single(.error(AuthUserError.cannotGetUserInfo))
                return Disposables.create()
            }
            var chats = chats
            let chatsRef = self.db.collection(["users", currentUserId, "waitingChats"].joined(separator: "/"))
            let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, _) in
                guard let snapshot = querySnapshot else {
                    return single(.error(AuthUserError.cannotGetUserInfo))
                }
                snapshot.documentChanges.forEach { diff in
                    guard let chat = AppChat(document: diff.document) else { return }
                    switch diff.type {
                    case .added:
                        guard !chats.contains(chat) else { return }
                        chats.append(chat)
                    case .modified:
                        guard let index = chats.firstIndex(of: chat) else { return }
                        chats[index] = chat
                    case .removed:
                        guard let index = chats.firstIndex(of: chat) else { return }
                        chats.remove(at: index)
                    }
                }
                completion(chats)
            }
            single(.success(chatsListener))
            return Disposables.create()
        }
    }
    
}
