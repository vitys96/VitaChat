//
//  ChatsInteractor.swift
//  VitaChat
//
//  Created Vitaly on 13.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ChatsInteractor {

    // MARK: - Protocol properties
    weak var output: ChatsInteractorOutput?

    // MARK: - Properties
//    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - ChatsInteractorInput
extension ChatsInteractor: ChatsInteractorInput {}
