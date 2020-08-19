//
//  PeopleInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import RxSwift
import UIKit

final class PeopleInteractor {

    // MARK: - Protocol properties
    weak var output: PeopleInteractorOutput?
    private let userService: UserServiceProtocol
    private let firestoreService: FirestoreServiceProtocol
    private var usersListener: ListenerRegistration?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(userService: UserServiceProtocol, firestoreService: FirestoreServiceProtocol) {
        self.userService = userService
        self.firestoreService = firestoreService
    }

    deinit {
        usersListener?.remove()
    }

    // MARK: - Private methods

}

// MARK: - PeopleInteractorInput
extension PeopleInteractor: PeopleInteractorInput {

    func fetchUsersData(with users: [AppUser], userId: String) {
        firestoreService.observeUsers(users: users, currentUserId: userId, completion: { (users) in
            self.output?.usersDidFetched(users: users)
        })
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] usersListener in
                self.usersListener = usersListener
                },
                //MARK:- сделать обработку ошибки
                onError: { [unowned self] in print($0)
            })
            .disposed(by: disposeBag)
    }

    func logOutUser() {
        userService.deleteUserAccount()
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        output?.userDidLogOut()
    }

}
