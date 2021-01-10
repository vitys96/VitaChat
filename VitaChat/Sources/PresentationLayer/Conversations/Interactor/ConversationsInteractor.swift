//
//  ConversationsInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import FirebaseFirestore

final class ConversationsInteractor {
    
    // MARK: - Protocol properties
    weak var output: ConversationsInteractorOutput?
    private var waitingChatsListener: ListenerRegistration?
    private let listenerService: ListenerServiceProtocol
    private let userService: UserServiceProtocol
    private let firestoreService: FirestoreServiceProtocol
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(listenerService: ListenerServiceProtocol,
         userService: UserServiceProtocol,
         firestoreService: FirestoreServiceProtocol) {
        self.listenerService = listenerService
        self.userService = userService
        self.firestoreService = firestoreService
    }
    
    deinit {
        waitingChatsListener?.remove()
    }
    
}

// MARK: - ConversationsInteractorInput
extension ConversationsInteractor: ConversationsInteractorInput {
    
    func addWaitingChat(_ chat: AppChat) {
        guard let id = userService.getUser()?.id else {
            return
        }
        firestoreService.changeToActiveChat(currentUserId: id, chat: chat)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] in self.output?.performSuccess() },
                       onError: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func removeWaitingChat(_ chat: AppChat) {
        guard let id = userService.getUser()?.id else {
            return
        }
        firestoreService.deleteWaitingChat(currentUserId: id, chat: chat)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] in self.output?.performSuccess() },
                       onError: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func fetchChats(with chats: [AppChat]) {
        listenerService.waitingChatsObserve(chats: chats) { [weak self] chats in
            guard let self = self else { return }
            self.output?.chatsDidFetched(chats: chats)
        }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] in self.waitingChatsListener = $0 },
                       onError: { print($0) })
            .disposed(by: disposeBag)
    }
    
}
