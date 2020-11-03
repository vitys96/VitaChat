//
//  ProfileViewModel.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

struct ProfileViewModel {

    // MARK: - Properties
    let avatarImageUrl: URL?
    let welcome: NSAttributedString
    let fullName: NSAttributedString
    let aboutMe: NSAttributedString
    let fullNameTextFieldPlaceholder: String
    let aboutMeTextFieldPlaceholder: String
    let sex: NSAttributedString
    let segmentedControlNormalAttributes: [NSAttributedString.Key : Any]
    let segmentedControlSelectedAttributes: [NSAttributedString.Key : Any]

    // MARK: - Init
    init(with avatarImageUrl: URL?) {
        let standardColor = DIContainer.colorManager.n1
        let whiteColor = DIContainer.colorManager.staticWhite

        welcome = "Создание профиля".addAttributes(fontStyle: .bold, size: 26, color: standardColor)
        fullName = "Ваше Имя".addAttributes(fontStyle: .regular, size: 20, color: standardColor)
        aboutMe = "Пару слов о себе".addAttributes(fontStyle: .regular, size: 20, color: standardColor)
        fullNameTextFieldPlaceholder = "Виталий Охрименко"
        aboutMeTextFieldPlaceholder = "Люблю читать русскую классику"
        sex = "Выберите Пол".addAttributes(fontStyle: .regular, size: 20, color: standardColor)
        segmentedControlNormalAttributes = [.foregroundColor: DIContainer.colorManager.n1]
        segmentedControlSelectedAttributes = [.foregroundColor: whiteColor]
        self.avatarImageUrl = avatarImageUrl
    }

}
