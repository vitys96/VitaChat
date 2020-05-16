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

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(firestoreService: FirestoreServiceProtocol, validationService: ValidationServiceProtocol) {
        self.firestoreService = firestoreService
        self.validationService = validationService
    }

    // MARK: - Private methods

}

// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {

    func saveUserProfile(id: String, email: String, contactInfo: ContactInfo, imageUrl: String?) {
        firestoreService.saveProfileWith(id: id,
                                         email: email,
                                         username: contactInfo.userName,
                                         avatarImage: nil,
                                         description: contactInfo.description,
                                         sex: contactInfo.sex) { result in
                                            switch result {
                                            case .success(let user):
                                                print("ZAEBIS")
                                            case .failure(let error):
                                                print("XUEVO")
                                            }
        }
    }

    func validateContacts(_ contacts: ContactInfo) -> Bool {
        let isUserNameValid = validationService.isValidUserName(contacts.userName)
        let isDescriptionValid = validationService.isValidDescription(contacts.description)

        return isUserNameValid && isDescriptionValid
    }

}
