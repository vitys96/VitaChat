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

    // MARK: - Properties

    // MARK: - Init
    init(interactor: HumanProfileInteractorInput, router: HumanProfileRouterInput) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - HumanProfileViewOutput
extension HumanProfilePresenter: HumanProfileViewOutput {
    func viewDidLoad() {}
}

// MARK: - HumanProfileInteractorOutput
extension HumanProfilePresenter: HumanProfileInteractorOutput {
    
}

