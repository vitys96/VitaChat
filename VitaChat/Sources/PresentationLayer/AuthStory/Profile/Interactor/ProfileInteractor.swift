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

    func saveUserProfile(id: String, email: String, contactInfo: ContactInfo, image: UIImage?) {
        guard let image = image else {
            // MARK: - обработать кейс, когда юзер не загрузил фото
            return
        }
        firestoreService.uploadPhoto(image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let savedImageUrl):
                self.firestoreService.saveProfileWith(id: id,
                                                 email: email,
                                                 username: contactInfo.userName,
                                                 avatarImageUrl: savedImageUrl.absoluteString,
                                                 description: contactInfo.description,
                                                 sex: contactInfo.sex)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onSuccess: { [unowned self] in self.userFetched(user: $0)},
                               onError: { [unowned self] in self.output?.errorFetched(error: $0)
                })
                    .disposed(by: self.disposeBag)
            case .failure(_):
                print("laal")
            // MARK: - обработать кейс, когда не удалось загрузить фото юзера
            }
        }
    }

    func validateContacts(_ contacts: ContactInfo) -> Bool {
        let isUserNameValid = validationService.isValidUserName(contacts.userName)
        let isDescriptionValid = validationService.isValidDescription(contacts.description)

        return isUserNameValid && isDescriptionValid
    }

}
