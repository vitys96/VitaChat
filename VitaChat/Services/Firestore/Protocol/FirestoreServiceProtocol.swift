//
//  FirestoreServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseFirestore
import RxSwift

protocol FirestoreServiceProtocol {

    func getUserData(user: User) -> Single<AppUser>

    func saveProfileWith(id: String, email: String, username: String?, avatarImageUrl: String,
                         description: String?, sex: String) -> Single<AppUser>

    func observeUsers(users: [AppUser], currentUserId: String,
                      completion: @escaping ([AppUser]) -> Void) -> Single<ListenerRegistration>

    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void)

    func uploadPhoto1(with image: UIImage) -> Single<URL>
    
    func createWaitingChats(currentUser: AppUser, message: String, receiver: AppUser) -> Single<Void>
    
    func deleteWaitingChat(currentUserId: String, chat: AppChat) -> Single<Void>
    
    func changeToActiveChat(currentUserId: String, chat: AppChat) -> Single<Void>

}
