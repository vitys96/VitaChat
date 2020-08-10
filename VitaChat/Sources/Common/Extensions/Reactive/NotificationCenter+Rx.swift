//
//  NotificationCenter+Rx.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 08.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift

extension Reactive where Base: NotificationCenter {

    var keyboardInfo: Observable<(CGFloat)> {
        return keyboardHeight
    }

    private var keyboardHeight: Observable<CGFloat> {
        let shownKeyboardHeight = willShowKeyboardNotification
            .map { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0?.cgRectValue.height }
            .flatMap { Observable.from(optional: $0) }
        let hiddenKeyboardHeight = willHideKeyboardNotification.map { _ in CGFloat(0) }

        return Observable.merge(shownKeyboardHeight, hiddenKeyboardHeight)
    }

    private var willShowKeyboardNotification: Observable<Notification> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
    }

    private var willHideKeyboardNotification: Observable<Notification> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
    }

}
