//
//  AuthViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 01.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import GoogleSignIn
import FirebaseAuth
import PinLayout
import RxSwift

final class AuthViewController: BaseViewController {

    // MARK: - Subviews
    private let googleLabel = UILabel().with {
        $0.text = "Продолжить через"
        $0.textAlignment = .center
    }
    private let emailLabel = UILabel().with {
        $0.text = "Или зарегистрируйтесь через"
    }
    private let alreadyOnBoardLabel = UILabel().with {
        $0.text = "Уже есть учетная запись?"
    }
    private lazy var googlelButton = StandardButton(title: "Google", backgroundColor: colorManager.n11).with {
        $0.setTitleColor(colorManager.n1, for: .normal)
    }
    private lazy var emailButton = StandardButton(title: "Email").with {
        $0.setTitleColor(colorManager.n11, for: .normal)
    }
    private lazy var loginButton = StandardButton(title: "Войти", backgroundColor: colorManager.n11).with {
        $0.setTitleColor(colorManager.n8, for: .normal)
    }

    // MARK: - Protocol properties
    private let output: AuthViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init(output: AuthViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Binding
    private func bindObservable() {
        [googlelButton, emailButton, loginButton].forEach { $0.animateWhenPressed(disposeBag: disposeBag) }
        googlelButton.rx.tap.subscribe(onNext: { [unowned self] _ in
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn()
        })
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in self.output.didTapLoginButton() })
            .disposed(by: disposeBag)

        emailButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in self.output.didTapSignUpButton() })
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

        loginButton.pin
            .horizontally(30)
            .sizeToFit(.width)
            .bottom(view.pin.safeArea.bottom)
            .marginBottom(30)

        alreadyOnBoardLabel.pin
            .sizeToFit()
            .above(of: loginButton, aligned: .left)
            .left(to: loginButton.edge.left)
            .marginBottom(18)

        emailButton.pin
            .horizontally(30)
            .sizeToFit(.width)
            .above(of: alreadyOnBoardLabel)
            .marginBottom(30)

        emailLabel.pin
            .sizeToFit()
            .above(of: emailButton, aligned: .left)
            .left(to: emailButton.edge.left)
            .marginBottom(18)

        googlelButton.pin
            .horizontally(30)
            .sizeToFit(.width)
            .above(of: emailLabel)
            .marginBottom(30)

        googleLabel.pin
            .sizeToFit()
            .above(of: googlelButton, aligned: .left)
            .left(to: googlelButton.edge.left)
            .marginBottom(18)

    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            googleLabel,
            loginButton,
            alreadyOnBoardLabel,
            emailButton,
            emailLabel,
            googlelButton,
        ])

        setupActivityIndicator()
    }

    private func configure() {
        view.backgroundColor = colorManager.n11
        GIDSignIn.sharedInstance()?.delegate = self
    }

}

// MARK: - AuthViewInput
extension AuthViewController: AuthViewInput {

    func showData() {
    }

}


// MARK: - GIDSignInDelegate
extension AuthViewController: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let user = user {
            self.output.didSigned(user: user, withError: error)
        }
    }

}
