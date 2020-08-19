//
//  ProfileBuilder.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//
//  Template generated by Okhrimenko Vitaly @vitys96
//  https://github.com/vitys96/VIPER-module
//

import FirebaseAuth

final class ProfileBuilder {

    // MARK: - Init
    private init() {}

}

// MARK: - ProfileBuilderProtocol
extension ProfileBuilder: ProfileBuilderProtocol {

    static func build(with context: ProfileContext) -> ProfileViewController {
        let interactor = ProfileInteractor(firestoreService: DIContainer.firestoreService,
                                           validationService: DIContainer.validationService,
                                           userService: DIContainer.userService)
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interactor: interactor, router: router,
                                         user: context.user,
                                         cameraManager: DIContainer.cameraManager)
        let viewController = ProfileViewController(output: presenter)

        presenter.view = viewController
        interactor.output = presenter
        router.view = viewController

        return viewController
    }

}

struct ProfileContext {

    let user: User?

}
