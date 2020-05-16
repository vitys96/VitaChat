//
//  SignUpInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class SignUpInteractor {

    // MARK: - Protocol properties
    weak var output: SignUpInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - SignUpInteractorInput
extension SignUpInteractor: SignUpInteractorInput {}
