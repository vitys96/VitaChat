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
    static func build(with user: User) -> ProfileViewController
}

// MARK: - View
protocol ProfileViewInput: class {

    func startLoadingAnimation()

    func stopLoadingAnimation()

    /**
     Заполнить экран профиля
     */
    func showProfileView(model: ProfileViewModel)

}

protocol ProfileViewOutput {
   /**
     Метод сообщающий, что view была загружена
   */
    func viewDidLoad()

    func saveUserData(id: String, email: String, contactInfo: ContactInfo, imageUrl: String?)
}

// MARK: - Interactor
protocol ProfileInteractorInput {

    func saveUserProfile(id: String, email: String, contactInfo: ContactInfo, imageUrl: String?)

    func validateContacts(_ contacts: ContactInfo) -> Bool

}
protocol ProfileInteractorOutput: class {}

// MARK: - Router
protocol ProfileRouterInput {}
