//
//  FirestoreService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseFirestore
import RxSwift


final class FirestoreService {
    
    // MARK: - Properties
    let db = Firestore.firestore()

    private let storageService: StorageSeviceProtocol
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(storageService: StorageSeviceProtocol) {
        self.storageService = storageService
    }
    
    private func saveUser(uid: String, userData: AppUser) -> Observable<AppUser> {
        return Single<AppUser>.create { single in
            self.usersRef.document(uid).setData(userData.representation) { error in
                if let err = error {
                    return single(.error(err))
                } else {
                    single(.success(userData))
                }
            }
            return Disposables.create()
        }.asObservable()
    }
    
    private func getDocument(docRef: DocumentReference) -> Observable<AppUser> {
        return Single<AppUser>.create { single in
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    guard let appUser = AppUser(document: document) else {
                        return single(.error(AuthUserError.cannotUnwrapToUser))
                    }
                    single(.success(appUser))
                } else {
                    return single(.error(AuthUserError.cannotGetUserInfo))
                }
            }
            return Disposables.create()
        }.asObservable()
    }
    
    private func observe(with usersData: [AppUser], currentUserId: String,
                         completion: @escaping ([AppUser]) -> Void) -> Observable<ListenerRegistration> {
        var users = usersData
        return Single<ListenerRegistration>.create { (single) -> Disposable in
            let usersListener = self.usersRef.addSnapshotListener { (querySnapshot, error) in
                if let err = error {
                    return single(.error(err))
                }
                guard let snapshot = querySnapshot else {
                    return single(.error(SignUpError.unknownError))
                }
                snapshot.documentChanges.forEach { (diff) in
                    guard let appUser = AppUser(document: diff.document) else { return }
                    switch diff.type {
                    case .added:
                        guard !users.contains(appUser), appUser.id != currentUserId else { return }
                        users.append(appUser)
                    case .modified:
                        guard let index = users.firstIndex(of: appUser) else { return }
                        users[index] = appUser
                    case .removed:
                        guard let index = users.firstIndex(of: appUser) else { return }
                        users.remove(at: index)
                    }
                }
                completion(users)
            }
            single(.success(usersListener))
            return Disposables.create()
        }.asObservable()
    }
    
    private func deleteMessages(currentUserId: String, chat: AppChat) -> Observable<Void> {
        let waitingChatRef = db.collection(["users", currentUserId, "waitingChats"].joined(separator: "/"))
        let reference = waitingChatRef.document(chat.friendId).collection("messages")
        return Single<Void>.create { single in
            waitingChatRef.document(chat.friendId).delete { error in
                if let err = error {
                    return single(.error(err))
                }
                self.getWaitingChatMessages(currentUserId: currentUserId, chat: chat) { result in
                    switch result {
                    case .success(let messages):
                        for message in messages {
                            guard let documentId = message.id else { return }
                            let messageRef = reference.document(documentId)
                            messageRef.delete { (error) in
                                if let error = error {
                                    return single(.error(error))
                                }
                                return single(.success(()))
                            }
                        }
                    case .failure(let error):
                        return single(.error(error))
                    }
                }
            }
            return Disposables.create()
        }.asObservable()
    }
    
    func getWaitingChatMessages(currentUserId: String, chat: AppChat,
                                 completion: @escaping (Result<[AppMessage], Error>) -> Void) {
        let waitingChatRef = db.collection(["users", currentUserId, "waitingChats"].joined(separator: "/"))
        let reference = waitingChatRef.document(chat.friendId).collection("messages")
        var messages = [AppMessage]()
        reference.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let querySnapshot = querySnapshot else {
                return
            }
            for document in querySnapshot.documents {
                guard let message = AppMessage(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
    
    private func createActiveChat(currentUserId: String, chat: AppChat, messages: [AppMessage]) -> Single<Void> {
        let activeChatsRef = db.collection(["users", currentUserId, "activeChats"].joined(separator: "/"))
        let messageRef = activeChatsRef.document(chat.friendId).collection("messages")
        return Single<Void>.create { single in
            activeChatsRef.document(chat.friendId).setData(chat.representation) { (error) in
                if let error = error {
                    return single(.error(error))
                }
                for message in messages {
                    messageRef.addDocument(data: message.representation) { (error) in
                        if let error = error {
                            return single(.error(error))
                        }
                        single(.success(()))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
}

// MARK: - FirestoreServiceProtocol
extension FirestoreService: FirestoreServiceProtocol {
    
    func changeToActiveChat(currentUserId: String, chat: AppChat) -> Single<Void> {
        return Single<Void>.create { single in
            self.getWaitingChatMessages(currentUserId: currentUserId, chat: chat) { result in
                switch result {
                case .success(let messages):
                    self.deleteMessages(currentUserId: currentUserId, chat: chat).asSingle()
                        .subscribe(
                            onSuccess: { [unowned self] _ in
                                createActiveChat(currentUserId: currentUserId, chat: chat, messages: messages)
                                    .subscribe(
                                        onSuccess: { [unowned self] _ in
                                            return single(.success(()))
                                        },
                                        onError: { [unowned self] _ in print("lala") })
                            },
                            onError: { [unowned self] _ in print("lala") })
                        .disposed(by: self.disposeBag)
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func deleteWaitingChat(currentUserId: String, chat: AppChat) -> Single<Void> {
        return deleteMessages(currentUserId: currentUserId, chat: chat).asSingle()
    }
    
    func createWaitingChats(currentUser: AppUser, message: String, receiver: AppUser) -> Single<Void> {
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(currentUser.id).collection("messages")
        
        let message = AppMessage(user: currentUser, content: message)
        let chat = AppChat(friendUsername: currentUser.username,
                           friendAvatarStringURL: currentUser.avatarStringURL,
                           friendId: currentUser.id,
                           lastMessageContent: message.content)
        
        return Single<Void>.create { single in
            reference.document(currentUser.id).setData(chat.representation) { error in
                if let err = error {
                    return single(.error(err))
                }
                messageRef.addDocument(data: message.representation) { error in
                    if let err = error {
                        return single(.error(err))
                    }
                    return single(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    
    func uploadPhoto1(with image: UIImage) -> Single<URL> {
        storageService.uploadPhoto1(with: image).asSingle()
    }
    
    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        storageService.upload(photo: image, completion: completion)
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImageUrl: String, description: String?,
                         sex: String) -> Single<AppUser> {
        guard let name = username, let descr = description else {
            return .error(AuthUserError.notFilled)
        }
        let user = AppUser(username: name,
                           email: email,
                           avatarStringURL: avatarImageUrl,
                           description: descr,
                           sex: sex,
                           id: id)
        return saveUser(uid: id, userData: user).asSingle()
    }
    
    func getUserData(user: User) -> Single<AppUser> {
        let docRef = usersRef.document(user.uid)
        return getDocument(docRef: docRef).asSingle()
    }
    
    func observeUsers(users: [AppUser], currentUserId: String,
                      completion: @escaping ([AppUser]) -> Void) -> Single<ListenerRegistration> {
        return observe(with: users, currentUserId: currentUserId, completion: completion).asSingle()
    }
}
