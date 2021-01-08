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
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(listenerService: ListenerServiceProtocol) {
        self.listenerService = listenerService
    }
    
    deinit {
        waitingChatsListener?.remove()
    }
    
    // MARK: - Private methods
    
}

// MARK: - ConversationsInteractorInput
extension ConversationsInteractor: ConversationsInteractorInput {
    
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
