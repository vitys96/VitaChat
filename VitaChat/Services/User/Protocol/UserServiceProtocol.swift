//
//  UserServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 12.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift

protocol UserServiceProtocol {

    /**
    Сохраняет текущего авторизованного пользователя
    */
    func saveUser(_ user: AppUser)
    /**
    Возвращает текущего авторизованного пользователя
    */
    func getUser() -> AppUser?
    /**
     Возвращает флаг "Пользователь авторизован"
    */
    func isUserAuthorized() -> Bool
    /**
     Удаление всех данных аккаунта пользователя из хранилища
    */
    func deleteUserAccount()

}
