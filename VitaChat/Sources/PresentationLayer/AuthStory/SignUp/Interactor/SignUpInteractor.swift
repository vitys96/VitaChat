//
//  SignUpInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseAuth
import UIKit

final class SignUpInteractor {

    // MARK: - Protocol properties
    weak var output: SignUpInteractorOutput?
    private let validationService: ValidationServiceProtocol

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(validationService: ValidationServiceProtocol) {
        self.validationService = validationService
    }

    // MARK: - Private methods

}

// MARK: - SignUpInteractorInput
extension SignUpInteractor: SignUpInteractorInput {

    func registerUser(with contacts: SignUpContacts) {
        validationService.isValidSignUpRegister(model: contacts)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [unowned self] in self.output?.userFetched(user: $0)},
                       onError: { [unowned self] in self.output?.errorFetched(error: $0)
        })
            .disposed(by: disposeBag)
    }

}
