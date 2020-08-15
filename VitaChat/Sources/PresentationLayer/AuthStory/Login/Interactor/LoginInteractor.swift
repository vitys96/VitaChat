//
//  LoginInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 09.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import RxSwift

final class LoginInteractor {

    // MARK: - Protocol properties
    weak var output: LoginInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {}
