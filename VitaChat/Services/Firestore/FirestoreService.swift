//
//  FirestoreService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseFirestore


final class FirestoreService {

    // MARK: - Properties
    let db = Firestore.firestore()

    private var usersRef: CollectionReference {
        return db.collection("users")
    }

    // MARK: - Init
    init() {}

}

extension FirestoreService: FirestoreServiceProtocol {

    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?,
                         sex: String, completion: @escaping (Result<AppUser, Error>) -> Void) {

        guard let name = username, let descr = description else { return }

        let user = AppUser(username: name,
                           email: email,
                           avatarStringURL: "not exist",
                           description: descr,
                           sex: sex,
                           id: id)
        usersRef.document(id).setData(user.representation) { error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(user))
            }
        }

    }

    func getUserData(user: User, completion: @escaping (Result<AppUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = AppUser(document: document) else {
                    completion(.failure(AuthUserError.cannotUnwrapToUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(AuthUserError.cannotGetUserInfo))
            }
        }
    }
}
