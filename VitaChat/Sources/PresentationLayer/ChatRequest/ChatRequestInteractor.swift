//
//  ChatRequestInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 20.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class ChatRequestInteractor {

    // MARK: - Protocol properties
    weak var output: ChatRequestInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - ChatRequestInteractorInput
extension ChatRequestInteractor: ChatRequestInteractorInput {}
