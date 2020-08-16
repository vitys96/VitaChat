//
//  ConversationsInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class ConversationsInteractor {

    // MARK: - Protocol properties
    weak var output: ConversationsInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - ConversationsInteractorInput
extension ConversationsInteractor: ConversationsInteractorInput {}
