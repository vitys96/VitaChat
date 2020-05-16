//
//  BaseViewController.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 09.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import RxSwift
import JGProgressHUD

class BaseViewController: UIViewController {

    // MARK: - Properties

    /**
     Все контроллеры, наследующие от данного, будут иметь данный background color.
     Наследник может поставить свой цвет.
    */
    var backgroundColor: UIColor? = DIContainer.colorManager.n13 {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }

    // MARK: - Subviews
    private var activityIndicator: JGProgressHUD?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        activityIndicator?.pin.center(to: view.anchor.center)
    }

    // MARK: - Activity Indicator
    final func setupActivityIndicator() {
        guard activityIndicator == nil else {
            return
        }

        let activityIndicator = JGProgressHUD(style: .light)
        view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
    }

    final func startLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator?.show(in: self.view)
        }
    }

    final func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator?.dismiss()
        }
    }

}

