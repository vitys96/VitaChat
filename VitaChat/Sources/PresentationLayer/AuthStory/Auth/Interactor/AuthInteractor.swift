//
//  AuthInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import GoogleSignIn
import UIKit
import RxSwift

final class AuthInteractor {

    // MARK: - Protocol properties
    weak var output: AuthInteractorOutput?
    private let authService: AuthServiceProtocol
    private let firestoreService: FirestoreServiceProtocol
    private let userService: UserServiceProtocol

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(authService: AuthServiceProtocol, firestoreService: FirestoreServiceProtocol, userService: UserServiceProtocol) {
        self.authService = authService
        self.firestoreService = firestoreService
        self.userService = userService
    }

    // MARK: - Private methods

}

// MARK: - AuthInteractorInput
extension AuthInteractor: AuthInteractorInput {

    func userAuthByGoogle(user: GIDGoogleUser, withError error: Error?) {
        authService.googleLogin(user: user, error: error)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] fetchedUser in
                self.firestoreService.getUserData(user: fetchedUser)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: { [unowned self] in
                        self.output?.userDidExistInDB(user: $0)
                        self.userService.saveUser($0)
                        },
                               onError: { [unowned self] _ in self.output?.userDidNotExistInDB(user: fetchedUser)} )
                    .disposed(by: self.disposeBag)
                },
                       onError: { [unowned self] in
                        self.output?.userFetchedWithError(error: $0)
            })
            .disposed(by: disposeBag)
    }

}
