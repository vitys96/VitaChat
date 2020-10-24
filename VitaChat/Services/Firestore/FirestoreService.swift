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

    private let storageService: StorageSeviceProtocol

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
                        guard !users.contains(appUser) else { return }
                        guard appUser.id != currentUserId else { return }
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

}

// MARK: - FirestoreServiceProtocol
extension FirestoreService: FirestoreServiceProtocol {

    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?,
                         sex: String) -> Single<AppUser> {

        guard let name = username, let descr = description else {
            return .error(AuthUserError.notFilled)
        }
        guard let imageUser = avatarImage else {
            return .error(AuthUserError.photoNotExist)
        }
        var user = AppUser(username: name,
                           email: email,
                           avatarStringURL: "not exist",
                           description: descr,
                           sex: sex,
                           id: id)
        storageService.upload(photo: imageUser) { result in
            switch result {
            case .success(let url):
                user.avatarStringURL = url.absoluteString
            case .failure(_):
                print("laal")
            }
        }
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
