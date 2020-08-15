//
//  ValidationServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseAuth

protocol ValidationServiceProtocol {

    func isValidUserName(_ name: String?) -> Bool

    func isValidDescription(_ description: String?) -> Bool

    /**
      Метод, который проверяет валидность полей, заполненных на экране Регистрации (SignUp Screen)
    */
    func isValidSignUpRegister(model: SignUpContacts) -> Single<User>

}
