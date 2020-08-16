//
//  AuthServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import GoogleSignIn
import FirebaseAuth
import RxSwift

protocol AuthServiceProtocol {

    func googleLogin(user: GIDGoogleUser, error: Error?) -> Single<User>
}
