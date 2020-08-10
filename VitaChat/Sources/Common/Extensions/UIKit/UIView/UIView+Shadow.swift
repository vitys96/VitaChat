//
//  UIView+Shadow.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 02.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit.UIView

extension UIView {

    /**
     Использовать с осторожностью!

     - Important:
      Используется растеризация (кеширование тени, offscreen rendering) для оптимизации производительности.
      Но это хорошо работает только если layer не изменяется (размер, aplha),
      иначе добавление растеризации ухудшает производительность.

      Если тень добавляется к вью со скругленными углами,
      скругление не сработает корректно из-за layer.masksToBounds = false

      Не подходит для использования теней на масштабируемых вью,
      т.к. shouldRasterize дает искажение границы фрейма
     */
    func addShadow(radius: CGFloat, opacity: Float, offset: CGSize = .zero, color: CGColor? = nil) {
        color.map { layer.shadowColor = $0 }
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    /**
     Добавляет тень для вью с возможностью оптимизации производительности.

     - Important:
      Если вью имеет простой контур - прямоугольник со скругленными краями или без,
      рекомендуется использовать данную функцию.
      Во избежание потери производительности при отрисовки тени,
      необходимо установить параметр shouldSetPath = true.

      Не подходит для вью с layer.masksToBounds = true

     - Parameter shouldSetPath: флаг, отвечающий за генерацию shadowPath, используя view.bounds
     - Parameter radius: радиус blur'a тени
     - Parameter opacity: непрозрачность
     - Parameter offset: смещение
     - Parameter color: цвет, по умолчанию UIColor.black (НЕ инвертируется под разные темы)
     */
    func addShadow(shouldSetPath: Bool, radius: CGFloat, opacity: Float, offset: CGSize = .zero, color: CGColor? = nil) {
        if shouldSetPath {
            layer.shadowPath = layer.cornerRadius > 0 ?
                UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath :
                UIBezierPath(rect: bounds).cgPath
        }
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        color.map { layer.shadowColor = $0 }
        layer.masksToBounds = false
    }

    func removeShadow() {
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowColor = nil
        layer.shadowOffset = .zero
        layer.shadowPath = nil
    }

    func setupBorder(withColor color: UIColor, andWidth width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func rounded() {
        layer.cornerRadius = bounds.height / 2.0
    }

}
