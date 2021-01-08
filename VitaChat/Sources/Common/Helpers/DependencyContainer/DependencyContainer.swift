//
//  DependencyContainer.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Dip

final class DIContainer {

    // MARK: - Properties
    static let instance = DependencyContainer {
        unowned let container = $0

        // MARK: - Common services
        container.register { () -> [UIApplicationDelegate] in
            [
                AppearanceManager()
            ]
        }

        // MARK: - Managers
        container.register(.singleton) {
            ColorManager.shared as ColorManagerProtocol
        }

        container.register(.singleton) {
            FontManager.shared as FontManagerProtocol
        }

        container.register(.singleton) {
            CameraManager.shared as CameraManagerProtocol
        }

        // MARK: - Common services
        container.register {
            AuthService() as AuthServiceProtocol
        }
        container.register {
            ValidationService() as ValidationServiceProtocol
        }
        container.register {
            StorageService() as StorageSeviceProtocol
        }
        container.register {
            FirestoreService(storageService: try container.resolve()) as FirestoreServiceProtocol
        }
        container.register {
            UserService() as UserServiceProtocol
        }
        container.register {
            ListenerService() as ListenerServiceProtocol
        }

    }

    static var appDelegates: [UIApplicationDelegate] {
        let appDelegates: [UIApplicationDelegate] = (try? DIContainer.instance.resolve()) ?? []
        return appDelegates
    }

    // MARK: - Managers
    static var colorManager: ColorManagerProtocol {
        guard let colorManager = try? instance.resolve() as ColorManagerProtocol else {
            fatalError()
        }
        return colorManager
    }

    static var fontManager: FontManagerProtocol {
        guard let fontManager = try? instance.resolve() as FontManagerProtocol else {
            fatalError()
        }
        return fontManager
    }

    static var cameraManager: CameraManagerProtocol {
        guard let cameraManager = try? instance.resolve() as CameraManagerProtocol else {
            fatalError()
        }
        return cameraManager
    }

    static var authService: AuthServiceProtocol {
        guard let authService = try? instance.resolve() as AuthServiceProtocol else {
            fatalError()
        }
        return authService
    }

    static var validationService: ValidationServiceProtocol {
        guard let validationService = try? instance.resolve() as ValidationServiceProtocol else {
            fatalError()
        }
        return validationService
    }

    static var storageService: StorageSeviceProtocol {
        guard let storageService = try? instance.resolve() as StorageSeviceProtocol else {
            fatalError()
        }
        return storageService
    }

    static var firestoreService: FirestoreServiceProtocol {
        guard let firestoreService = try? instance.resolve() as FirestoreServiceProtocol else {
            fatalError()
        }
        return firestoreService
    }

    static var userService: UserServiceProtocol {
        guard let userService = try? instance.resolve() as UserServiceProtocol else {
            fatalError()
        }
        return userService
    }
    
    static var listenerService: ListenerServiceProtocol {
        guard let listenerService = try? instance.resolve() as ListenerServiceProtocol else {
            fatalError()
        }
        return listenerService
    }

}

