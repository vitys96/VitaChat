//
//  UIButton + PressAnimation.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIButton {

    func animateWhenPressed(disposeBag: DisposeBag) {
        let pressDownTransform = rx.controlEvent([.touchDown, .touchDragEnter])
            .map({ CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95) })

        let pressUpTransform = rx.controlEvent([.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
            .map({ CGAffineTransform.identity })

        Observable.merge(pressDownTransform, pressUpTransform)
            .distinctUntilChanged()
            .subscribe(onNext: animate(_:))
            .disposed(by: disposeBag)
    }

    private func animate(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.55,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {
                        self.transform = transform
        }, completion: nil)
    }

}

