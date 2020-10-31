//
//  ProfileContract.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import FirebaseAuth

// MARK: - Builder
protocol ProfileBuilderProtocol: class {
    static func build(with context: ProfileContext) -> ProfileViewController
}

// MARK: - View
protocol ProfileViewInput: class {

    func startLoadingAnimation()

    func stopLoadingAnimation()

    /**
     Заполнить экран профиля
     */
    func showProfileView(model: ProfileViewModel, avatarImageUrl: URL?)

    func changeAvatar(with image: UIImage)

}

protocol ProfileViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()

    func saveUserData(contactInfo: ContactInfo)

    func didTapAvatarButton(in view: UIViewController)
}

// MARK: - Interactor
protocol ProfileInteractorInput {

    func saveUserProfile(id: String, email: String, contactInfo: ContactInfo, image: UIImage?)

    func validateContacts(_ contacts: ContactInfo) -> Bool

}
protocol ProfileInteractorOutput: class {

    func errorFetched(error: Error)

    func userFetched(user: AppUser)
}

// MARK: - Router
protocol ProfileRouterInput {

    func showErrorAlert(title: String)

    func navigateToMainScreen(with user: AppUser)
}
