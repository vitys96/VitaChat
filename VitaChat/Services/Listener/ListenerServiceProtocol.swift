//
//  ListenerServiceProtocol.swift
//  VitaChat
//
//  Created by Vitaly on 06.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseFirestore
import RxSwift

protocol ListenerServiceProtocol {
    /*
     Метод для полученя чатов "ожидающих подтверждения"
     */
    func waitingChatsObserve(chats: [AppChat], completion: @escaping ([AppChat]) -> Void) -> Single<ListenerRegistration>
}
