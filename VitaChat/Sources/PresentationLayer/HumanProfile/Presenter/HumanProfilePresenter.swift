//
//  HumanProfilePresenter.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class HumanProfilePresenter {

    // MARK: - Protocol properties
    weak var view: HumanProfileViewInput?
    private var interactor: HumanProfileInteractorInput
    private let router: HumanProfileRouterInput
    private let user: AppUser

    // MARK: - Properties

    // MARK: - Init
    init(interactor: HumanProfileInteractorInput, router: HumanProfileRouterInput, user: AppUser) {
        self.interactor = interactor
        self.router = router
        self.user = user
    }

}

// MARK: - HumanProfileViewOutput
extension HumanProfilePresenter: HumanProfileViewOutput {

    func didTapSendMesssage(message: String) {
        view?.startLoadingAnimation()
        interactor.createWaitingChat(user: user, message: message)
    }
    
    func viewDidLoad() {
        view?.showData(with: HumanProfileViewModel(with: user))
    }

}

// MARK: - HumanProfileInteractorOutput
extension HumanProfilePresenter: HumanProfileInteractorOutput {

    func chatRequestFetchedSuccessfully() {
        view?.stopLoadingAnimation()
        router.dismiss()
    }
    
    func chatRequestFetched(with error: Error) {
        view?.stopLoadingAnimation()
        router.showErrorAlert(title: error.localizedDescription)
    }
    
}

