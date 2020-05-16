//
//  StorageSeviceProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

protocol StorageSeviceProtocol {

    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void)

}
