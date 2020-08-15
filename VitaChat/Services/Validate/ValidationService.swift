//
//  ValidationService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

final class ValidationService: ValidationServiceProtocol {

    private let auth = Auth.auth()

    private func createFirebaseUser(email: String, passwd: String) -> Observable<User> {
        return Single<User>.create { single in
            self.auth.createUser(withEmail: email, password: passwd) { (result, _) in
                guard let result = result else {
                    single(.error(SignUpError.unknownError))
                    return
                }
                single(.success(result.user))
            }
            return Disposables.create()
        }.asObservable()
    }

    // MARK: - SignUp Screen
    func isValidSignUpRegister(model: SignUpContacts) -> Single<User> {
        guard let email = model.email,
            let paswd = model.password,
            let confirmPswd = model.confirmPassword,
            !email.isEmpty, !paswd.isEmpty, !confirmPswd.isEmpty else {
                return .error(AuthUserError.notFilled)
        }

        guard paswd.lowercased() == confirmPswd.lowercased() else {
            return .error(SignUpError.passwordsNotMatched)
        }

        guard isSimpleEmail(email) else {
            return .error(SignUpError.invalidEmail)
        }

        return createFirebaseUser(email: email, passwd: paswd).asSingle()
    }

    func isValidUserName(_ name: String?) -> Bool {
        return name != nil && name?.count != 0
    }

    func isValidDescription(_ description: String?) -> Bool {
        return description != nil && description?.count != 0
    }

    private func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }

}
