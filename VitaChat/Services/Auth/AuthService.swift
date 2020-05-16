//
//  AuthService.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import GoogleSignIn

final class AuthService {

    // MARK: - Properties

    // MARK: - Init
    init() {}

}

extension AuthService: AuthServiceProtocol {

    func googleLogin(user: GIDGoogleUser, error: Error?, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let auth = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)

        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }

}

