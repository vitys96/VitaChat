//
//  ChatsPresenter.swift
//  VitaChat
//
//  Created Vitaly on 13.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//
//  Template generated by Sakhabaev Egor @Banck
//  https://github.com/Banck/Swift-viper-template-for-xcode
//

import UIKit

final class ChatsPresenter {

    // MARK: - Protocol properties
    weak var view: ChatsViewInput?
    private var interactor: ChatsInteractorInput
    private let router: ChatsRouterInput

    // MARK: - Properties

    // MARK: - Init
    init(interactor: ChatsInteractorInput, router: ChatsRouterInput) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - ChatsViewOutput
extension ChatsPresenter: ChatsViewOutput {
    func viewDidLoad() {}
}

// MARK: - ChatsInteractorOutput
extension ChatsPresenter: ChatsInteractorOutput {
    
}

