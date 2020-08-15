//
//  UserService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 12.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

final class UserService: UserServiceProtocol {

    private let userDefaults = UserDefaults.standard

    // MARK: - User
    func saveUser(_ user: AppUser) {
        userDefaults.set(object: user, for: UserDefaultsKeys.user)
    }

    func getUser() -> AppUser? {
        return userDefaults.object(for: UserDefaultsKeys.user)
    }

}
