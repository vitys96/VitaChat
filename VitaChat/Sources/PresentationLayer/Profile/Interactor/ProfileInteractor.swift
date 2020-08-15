//
//  ProfileInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class ProfileInteractor {

    // MARK: - Protocol properties
    weak var output: ProfileInteractorOutput?
    private let firestoreService: FirestoreServiceProtocol
    private let validationService: ValidationServiceProtocol
    private let userService: UserServiceProtocol

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(firestoreService: FirestoreServiceProtocol, validationService: ValidationServiceProtocol, userService: UserServiceProtocol) {
        self.firestoreService = firestoreService
        self.validationService = validationService
        self.userService = userService
    }

    // MARK: - Private methods
    private func userFetched(user: AppUser) {
        userService.saveUser(user)
        output?.userFetched(user: user)
    }

}

// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {

    func saveUserProfile(id: String, email: String, contactInfo: ContactInfo, imageUrl: String?) {
        firestoreService.saveProfileWith(id: id,
                                         email: email,
                                         username: contactInfo.userName,
                                         avatarImage: nil,
                                         description: contactInfo.description,
                                         sex: contactInfo.sex)
        .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] in self.userFetched(user: $0)},
                       onError: { [unowned self] in self.output?.errorFetched(error: $0)
        })
            .disposed(by: disposeBag)
    }

    func validateContacts(_ contacts: ContactInfo) -> Bool {
        let isUserNameValid = validationService.isValidUserName(contacts.userName)
        let isDescriptionValid = validationService.isValidDescription(contacts.description)

        return isUserNameValid && isDescriptionValid
    }

}
