//
//  LoginViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 09.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import PinLayout
import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Subviews
    private let welcomeLabel = UILabel().with {
        $0.textAlignment = .center
    }
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    private let confirmPasswordLabel = UILabel()
    private let emailTextField = OneLineTextField()
    private let passwordTextField = OneLineTextField().with {
        $0.isSecureTextEntry = true
    }
    private lazy var signUpButton = StandardButton(title: "Войти")

    // MARK: - Protocol properties
    private let output: LoginViewOutput
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()

    // MARK: - Properties

    // MARK: - Init
    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Binding
    private func bindObservable() {
        signUpButton.animateWhenPressed(disposeBag: disposeBag)
    }

    // MARK: Life cycle
    override func loadView() {
        view = UIView()
        addSubviews()
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        bindObservable()
        output.viewDidLoad()
    }

    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layout()
    }

    private func layout() {
        welcomeLabel.pin
            .sizeToFit()
            .hCenter()
            .top(10%)

        emailLabel.pin
            .below(of: welcomeLabel)
            .left(40)
            .marginTop(10%)
            .sizeToFit()

        emailTextField.pin
            .below(of: emailLabel)
            .sizeToFit(.width)
            .horizontally(40)
            .marginTop(15)

        passwordLabel.pin
            .below(of: emailTextField)
            .left(40)
            .marginTop(5%)
            .sizeToFit()

        passwordTextField.pin
            .below(of: passwordLabel)
            .sizeToFit(.width)
            .horizontally(40)
            .marginTop(15)

        signUpButton.pin
            .horizontally(25)
            .sizeToFit(.width)
            .bottom(view.pin.safeArea.bottom + Margin.x3)
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            welcomeLabel,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            signUpButton,
        ])
    }

    private func configure() {
        view.backgroundColor = colorManager.n11
    }

}

// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {

    func setupScreen(with model: LoginViewModel) {
        welcomeLabel.attributedText = model.title
        emailLabel.attributedText = model.emailTitle
        passwordLabel.attributedText = model.passwordTitle

        [emailTextField, passwordTextField].forEach { $0.defaultTextAttributes = model.textFieldAttributes }

        view.setNeedsLayout()
    }
}
