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
    private let uid: String
    private let email: String?

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ProfileInteractorInput, router: ProfileRouterInput, context: ProfileContext) {
        self.interactor = interactor
        self.router = router
        self.uid = context.uid
        self.email = context.email
    }

}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {

    func saveUserData(contactInfo: ContactInfo, imageUrl: String?) {
        view?.startLoadingAnimation()
        guard let email = email else {
            return
        }
        if interactor.validateContacts(contactInfo) {
            interactor.saveUserProfile(id: uid, email: email, contactInfo: contactInfo, imageUrl: imageUrl)
        }
    }

    func viewDidLoad() {
        view?.stopLoadingAnimation()
        view?.showProfileView(model: ProfileViewModel())
    }
}

// MARK: - ProfileInteractorOutput
extension ProfilePresenter: ProfileInteractorOutput {

    func errorFetched(error: Error) {
        view?.stopLoadingAnimation()
        router.showErrorAlert(title: error.localizedDescription)
    }

    func userFetched(user: AppUser) {
        view?.stopLoadingAnimation()
        router.navigateToMainScreen(with: user)
    }

    
}

