//
//  SignUpViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - Subviews
    private let welcomeLabel = UILabel().with {
        $0.text = "Good to see you!"
        $0.textAlignment = .center
    }
    private let emailLabel = UILabel().with {
        $0.text = "Email"
    }
    private let passwordLabel = UILabel().with {
        $0.text = "Password"
    }
    private let confirmPasswordLabel = UILabel().with {
        $0.text = "Confirm Password"
    }
    private let emailTextField = OneLineTextField().with {
        $0.placeholder = "E.x kaboo96@mail.ru"
    }
    private let passwordField = OneLineTextField().with {
        $0.placeholder = "E.x lala4502j"
    }
    private let confirmPasswordTextField = OneLineTextField().with {
        $0.placeholder = "E.x kaboo96@mail.ru"
    }
    private lazy var signUpButton = UIButton().with {
        $0.backgroundColor = colorManager.n1
        $0.setTitle("Sign Up", for: .normal)
        $0.setTitleColor(colorManager.n11, for: .normal)
        $0.roundWithShadow(cornerRadius: 10, shadowRadius: 10)
    }
    private let alreadyOnboardLabel = UILabel().with {
        $0.text = "Already onboard?"
    }
    private lazy var loginButton = UIButton().with {
        $0.setTitle("Login", for: .normal)
        $0.backgroundColor = colorManager.n11
        $0.setTitleColor(colorManager.n8, for: .normal)
    }

    // MARK: - Protocol properties
    private let output: SignUpViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()

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
    private func bindObservable() {}

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
            .horizontally()
            .top(40)

        emailLabel.pin
            .sizeToFit()
            .below(of: welcomeLabel, aligned: .left)
            .marginTop(60)

        emailTextField.pin
            .below(of: emailLabel)
            .horizontally(30)
            .sizeToFit()
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            welcomeLabel,
            emailLabel,
            emailTextField
        ])
    }

    private func configure() {
        view.backgroundColor = colorManager.n11
    }

}

// MARK: - SignUpViewInput
extension SignUpViewController: SignUpViewInput {}
