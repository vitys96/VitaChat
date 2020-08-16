//
//  PeopleInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import FirebaseAuth
import RxSwift
import UIKit

final class PeopleInteractor {

    // MARK: - Protocol properties
    weak var output: PeopleInteractorOutput?
    private let userService: UserServiceProtocol

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    // MARK: - Private methods

}

// MARK: - PeopleInteractorInput
extension PeopleInteractor: PeopleInteractorInput {

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
