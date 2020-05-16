//
//  FirestoreServiceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Firebase
import FirebaseFirestore

protocol FirestoreServiceProtocol {

    func getUserData(user: User, completion: @escaping (Result<AppUser, Error>) -> Void)
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?,
                         description: String?, sex: String, completion: @escaping (Result<AppUser, Error>) -> Void)
}