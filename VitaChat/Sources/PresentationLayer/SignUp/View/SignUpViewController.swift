//
//  SignUpViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import PinLayout
import UIKit

final class SignUpViewController: UIViewController {

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
    private let confirmPasswordTextField = OneLineTextField().with {
        $0.isSecureTextEntry = true
    }
    private lazy var signUpButton = StandardButton(title: "Зарегистрироваться")

    private lazy var loginButton = UIButton().with {
        $0.titleLabel?.adjustsFontForContentSizeCategory = true
        $0.backgroundColor = colorManager.n11
        $0.layer.cornerRadius = 10
    }

    // MARK: - Protocol properties
    private let output: SignUpViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()
    private var bottomMargin: CGFloat = Margin.x4

    // MARK: - Init
    init(output: SignUpViewOutput) {
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
        loginButton.animateWhenPressed(disposeBag: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in self.output.didTapLoginButton() })
            .disposed(by: disposeBag)
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
        let buttonHeight: CGFloat = 50

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

        confirmPasswordLabel.pin
            .below(of: passwordTextField)
            .left(40)
            .marginTop(5%)
            .sizeToFit()

        confirmPasswordTextField.pin
            .below(of: confirmPasswordLabel)
            .sizeToFit(.width)
            .horizontally(40)
            .marginTop(15)

        loginButton.pin
            .height(buttonHeight)
            .horizontally(40)
            .bottom(view.pin.safeArea.bottom + Margin.x3)
        loginButton.addShadow(shouldSetPath: true, radius: 10, opacity: 0.5, color: colorManager.staticBlack.cgColor)

        signUpButton.pin
            .horizontally(40)
            .sizeToFit(.width)
            .above(of: loginButton)
            .marginBottom(2%)
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            welcomeLabel,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            confirmPasswordLabel,
            confirmPasswordTextField,
            signUpButton,
            loginButton,
        ])
    }

    private func configure() {
        view.backgroundColor = colorManager.n11
    }

}

// MARK: - SignUpViewInput
extension SignUpViewController: SignUpViewInput {

    func setupScreen(with model: SignUpViewModel) {
        welcomeLabel.attributedText = model.title
        emailLabel.attributedText = model.emailTitle
        passwordLabel.attributedText = model.passwordTitle
        confirmPasswordLabel.attributedText = model.confirmPasswordTitle
//        signUpButton.setAttributedTitle(model.signUpButtonTitle, for: .normal)

        loginButton.setAttributedTitle(model.loginButtonTitle, for: .normal)
        [emailTextField, passwordTextField, confirmPasswordTextField].forEach { $0.defaultTextAttributes = model.textFieldAttributes }

        view.setNeedsLayout()
    }

}
