//
//  ProfilePresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ProfilePresenter {

    // MARK: - Protocol properties
    weak var view: ProfileViewInput?
    private var interactor: ProfileInteractorInput
    private let router: ProfileRouterInput

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ProfileInteractorInput, router: ProfileRouterInput) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {

    func saveUserData(id: String, email: String, contactInfo: ContactInfo, imageUrl: String?) {
        if interactor.validateContacts(contactInfo) {
            interactor.saveUserProfile(id: id, email: email, contactInfo: contactInfo, imageUrl: imageUrl)
        }
    }

    func viewDidLoad() {
        view?.stopLoadingAnimation()
        view?.showProfileView(model: ProfileViewModel())
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {
    
}

