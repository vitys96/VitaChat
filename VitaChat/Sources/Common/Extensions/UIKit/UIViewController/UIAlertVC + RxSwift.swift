//
//  UIAlertVC + RxSwift.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import JGProgressHUD
import RxSwift

extension UIViewController {

    func showAlert(title: String?, message: String?) -> Completable {
        return Completable.create { [weak self] completable in
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: { _ in
                completable(.completed)
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create()
        }
    }

}


extension UIViewController {
    func showErrorAlert(labelText: String? = nil, detailText: String?) {
        let errorAlert = JGProgressHUD(style: .dark)
        errorAlert.indicatorView = JGProgressHUDErrorIndicatorView()
        errorAlert.textLabel.text = labelText
        errorAlert.detailTextLabel.text = detailText
        errorAlert.show(in: self.view)
        errorAlert.dismiss(afterDelay: 2, animated: true)
        errorAlert.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }

    func showSuccessAlert(labelText: String? = nil, detailText: String?) {
        let errorAlert = JGProgressHUD(style: .dark)
        errorAlert.indicatorView = JGProgressHUDSuccessIndicatorView()
        errorAlert.textLabel.text = labelText
        errorAlert.detailTextLabel.text = detailText
        errorAlert.show(in: self.view, animated: true)
        errorAlert.dismiss(afterDelay: 2, animated: true)
        errorAlert.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }

    func startLoading() {
        let hud = JGProgressHUD(style: .dark)
        hud.tag = 100
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }

    func stopLoading() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }

    func showClosedErrorAlert(labelText: String?, detailText: String?, closedAction: @escaping (() -> Void)) {
        let errorAlert = JGProgressHUD(style: .dark)
        errorAlert.indicatorView = JGProgressHUDErrorIndicatorView()
        errorAlert.textLabel.text = labelText
        errorAlert.detailTextLabel.text = detailText
        errorAlert.show(in: view)
        errorAlert.tapOnHUDViewBlock = { (hud) in
            closedAction()
        }
        errorAlert.tapOutsideBlock = { (hud) in
            closedAction()
        }
    }
}
