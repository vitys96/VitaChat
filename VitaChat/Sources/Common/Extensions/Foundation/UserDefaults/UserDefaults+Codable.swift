//
//  UserDefaults+Codable.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 12.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import Foundation

extension UserDefaults {

    func object<T: Decodable>(for key: String) -> T? {
        guard let data = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func set<T: Encodable>(object: T, for key: String) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        set(data, forKey: key)
    }

}
