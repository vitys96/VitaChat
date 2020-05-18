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
     */
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let reuseIdentifier = String(describing: cellType)
        register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func registerView<T: UICollectionReusableView>(viewType: T.Type, elementKind: String) {
        let reuseIdentifier = String(describing: viewType)
        register(viewType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: reuseIdentifier)
    }

    /**
     Метод для регистрации ячеек
     - Parameter cellTypes: Массив классов ячеек
     */
    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    /**
     Метод для получения ранее зарегистированной ячейки
     - Parameter cellType: Класс ячейки
     - Parameter indexPath: IndexPath для которого надо получить ячейку
     - Returns: Ячейка
     */
    func dequeueReusableCell<T: UICollectionViewCell>(with cellType: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("You aren't register cell: \(cellType)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(with cellType: T.Type,
                                                                    elementKind: String,
                                                                    for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: cellType)
        guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                          withReuseIdentifier: reuseIdentifier,
                                                          for: indexPath) as? T else {
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

    func createSectionHeader(width: NSCollectionLayoutDimension,
                                     height: NSCollectionLayoutDimension,
                                     alignment: NSRectAlignment = .top) -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: width,
                                                       heightDimension: height)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: alignment)

        return sectionHeader
    }

}

