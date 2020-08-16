//
//  AuthService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import GoogleSignIn
import RxSwift

final class AuthService {

    // MARK: - Properties

    // MARK: - Init
    init() {}

    private func googleSignIn(user: GIDGoogleUser) -> Observable<User> {
        guard let auth = user.authentication else {
            return .error(SignUpError.unknownError)
        }
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        return Single<User>.create { single in
            Auth.auth().signIn(with: credential) { (result, error) in
                guard let result = result else {
                    if let err = error {
                        return single(.error(err))
                    }
                    return single(.error(SignUpError.unknownError))
                }
                single(.success(result.user))
            }
            return Disposables.create()
        }.asObservable()
    }

}

extension AuthService: AuthServiceProtocol {

    func googleLogin(user: GIDGoogleUser, error: Error?) -> Single<User> {
        if let err = error {
            return .error(err)
        }
        return googleSignIn(user: user).asSingle()
    }

}

