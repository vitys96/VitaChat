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

    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?,
                         description: String?, sex: String) -> Single<AppUser>

    func observeUsers(users: [AppUser], currentUserId: String,
                      completion: @escaping ([AppUser]) -> Void) -> Single<ListenerRegistration>
}
