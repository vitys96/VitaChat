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

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(authService: AuthServiceProtocol, firestoreService: FirestoreServiceProtocol) {
        self.authService = authService
        self.firestoreService = firestoreService
    }

    // MARK: - Private methods

}

// MARK: - AuthInteractorInput
extension AuthInteractor: AuthInteractorInput {

    func userAuthByGoogle(user: GIDGoogleUser, withError error: Error?) {
        authService.googleLogin(user: user, error: error) { result in
            switch result {
            case .success(let user):
                self.firestoreService.getUserData(user: user) { result in
                    switch result {
                    case .success(let appUser):
                        self.output?.userDidExistInDB(user: appUser)
                    case .failure:
                        self.output?.userDidNotExistInDB(user: user)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
