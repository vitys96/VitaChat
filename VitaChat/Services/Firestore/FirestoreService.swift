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

    private var usersRef: CollectionReference {
        return db.collection("users")
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

}

extension FirestoreService: FirestoreServiceProtocol {

    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?,
                         sex: String) -> Single<AppUser> {

        guard let name = username, let descr = description else {
            return .error(AuthUserError.notFilled)
        }

        let user = AppUser(username: name,
                           email: email,
                           avatarStringURL: "not exist",
                           description: descr,
                           sex: sex,
                           id: id)

        return saveUser(uid: id, userData: user).asSingle()

    }

    func getUserData(user: User) -> Single<AppUser> {
        let docRef = usersRef.document(user.uid)
        return getDocument(docRef: docRef).asSingle()
    }
}
