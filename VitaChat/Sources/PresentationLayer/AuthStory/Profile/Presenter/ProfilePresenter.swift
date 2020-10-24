//
//  ProfilePresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import FirebaseAuth
import UIKit

final class ProfilePresenter {

    // MARK: - Protocol properties
    weak var view: ProfileViewInput?
    private var interactor: ProfileInteractorInput
    private let router: ProfileRouterInput
    private let user: User?
    private let cameraManager: CameraManagerProtocol
    private var userSelectedImage: UIImage? = nil

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ProfileInteractorInput, router: ProfileRouterInput, user: User?,
         cameraManager: CameraManagerProtocol) {
        self.interactor = interactor
        self.router = router
        self.user = user
        self.cameraManager = cameraManager
    }

}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {

    func didTapAvatarButton(in view: UIViewController) {
        cameraManager.showActionSheet(vc: view) { (image) in
            if let image = image {
                self.view?.changeAvatar(with: image)
                self.userSelectedImage = image
            }
        }
    }

    func saveUserData(contactInfo: ContactInfo, imageUrl: String?) {
        view?.startLoadingAnimation()
        guard let user = user, let email = user.email else {
            return
        }
        if interactor.validateContacts(contactInfo) {
            interactor.saveUserProfile(id: user.uid, email: email, contactInfo: contactInfo, image: userSelectedImage)
        }
    }

    func viewDidLoad() {
        view?.stopLoadingAnimation()
//        guard let user = user else {
//            return
//        }
        view?.showProfileView(model: ProfileViewModel(), avatarImageUrl: user?.photoURL)
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

