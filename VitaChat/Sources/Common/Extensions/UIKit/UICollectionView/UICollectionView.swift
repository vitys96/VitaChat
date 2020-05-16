//
//  UICollectionView.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {

    /**
     Метод для регистрации ячеки
     - Parameter cellType: Класс ячейки
     - Authors: Bogdan Kostyuchenko.
     */
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let reuseIdentifier = String(describing: cellType)
        register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }

    /**
     Метод для регистрации ячеек
     - Parameter cellTypes: Массив классов ячеек
     - Authors: Bogdan Kostyuchenko.
     */
    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    /**
     Метод для получения ранее зарегистированной ячейки
     - Parameter cellType: Класс ячейки
     - Parameter indexPath: IndexPath для которого надо получить ячейку
     - Returns: Ячейка
     - Authors: Bogdan Kostyuchenko.
     */
    func dequeueReusableCell<T: UICollectionViewCell>(with cellType: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("You aren't register cell: \(cellType)")
        }
        return cell
    }

    /**
     Метод для регистрации ячейки
     - Parameter indexPath: IndexPath
     - Parameter cellClass: Класс ячейки
     - Returns: Ячейка
     */
    func cell<T: UICollectionViewCell>(at indexPath: IndexPath, for cellClass: T.Type) -> T {
        let reuseIdentifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        if let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Couldn't find \(cellClass)")
    }

}

