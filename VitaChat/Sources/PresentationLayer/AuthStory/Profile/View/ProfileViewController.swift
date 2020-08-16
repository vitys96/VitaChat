//
//  ProfileViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

final class ProfileViewController: BaseViewController {

    // MARK: - Subviews
    private let welcomeLabel = UILabel().with {
        $0.textAlignment = .center
    }
    private lazy var avatarButton = AddPhotoView()
    private let fullNameLabel = UILabel()
    private let aboutMeLabel = UILabel()
    private let fullNameTextField = OneLineTextField()
    private let aboutMeTextField = OneLineTextField()
    private let sexLabel = UILabel()

    private lazy var sexSegmentedControl = UISegmentedControl(items: ["Мужчина", "Женщина"]).with {
        $0.selectedSegmentIndex = 0
        $0.selectedSegmentTintColor = colorManager.tabBar
    }

    private lazy var goToChatsButton = StandardButton(title: "Начать общение", backgroundColor: colorManager.tabBar).with {
        $0.setTitleColor(colorManager.staticWhite, for: .normal)
    }

    // MARK: - Protocol properties
    private let output: ProfileViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()


    // MARK: - Init
    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Binding
    private func bindObservable() {
        goToChatsButton.animateWhenPressed(disposeBag: disposeBag)
        goToChatsButton.rx.tap
            .subscribe(onNext: { [unowned self] in self.goToChatsTapped() })
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

        bindObservable()
        output.viewDidLoad()
    }

    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layout()
    }

    private func layout() {
        let imageViewSize: CGFloat = 150
        let segmentedControlHeight: CGFloat = 36
        let buttonHeight: CGFloat = 50

        welcomeLabel.pin
            .hCenter()
            .sizeToFit()
            .top(10)

        avatarButton.pin
            .below(of: welcomeLabel)
            .hCenter()
            .size(imageViewSize)
            .marginTop(30)

        fullNameLabel.pin
            .below(of: avatarButton)
            .sizeToFit()
            .horizontally(30)
            .marginTop(20)

        fullNameTextField.pin
            .below(of: fullNameLabel)
            .sizeToFit(.width)
            .horizontally(30)
            .marginTop(10)

        aboutMeLabel.pin
            .sizeToFit()
            .below(of: fullNameTextField)
            .horizontally(30)
            .marginTop(40)

        aboutMeTextField.pin
            .below(of: aboutMeLabel)
            .sizeToFit(.width)
            .horizontally(30)
            .marginTop(10)

        sexLabel.pin
            .sizeToFit()
            .below(of: aboutMeTextField)
            .horizontally(30)
            .marginTop(40)

        sexSegmentedControl.pin
            .below(of: sexLabel)
            .horizontally(30)
            .height(segmentedControlHeight)
            .marginTop(10)

        goToChatsButton.pin
            .height(buttonHeight)
            .horizontally(30)
            .bottom(view.pin.safeArea.bottom + 8)

    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            welcomeLabel,
            avatarButton,
            fullNameLabel,
            fullNameTextField,
            aboutMeLabel,
            aboutMeTextField,
            sexLabel,
            sexSegmentedControl,
            goToChatsButton,
        ])

        setupActivityIndicator()
    }

    private func goToChatsTapped() {
        guard let sexTitle = sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)else {
            return
        }
        let contact = ContactInfo(userName: fullNameTextField.text,
                                  description: aboutMeTextField.text,
                                  sex: sexTitle)

        self.output.saveUserData(contactInfo: contact, imageUrl: "dkdkdk")
    }

}

// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {

    func showProfileView(model: ProfileViewModel) {
        welcomeLabel.attributedText = model.welcome
        fullNameLabel.attributedText = model.fullName
        fullNameTextField.placeholder = model.fullNameTextFieldPlaceholder
        aboutMeLabel.attributedText = model.aboutMe
        aboutMeTextField.placeholder = model.aboutMeTextFieldPlaceholder

        sexLabel.attributedText = model.sex

        goToChatsButton.setAttributedTitle(model.actionButtonTitle, for: .normal)
        sexSegmentedControl.setTitleTextAttributes(model.segmentedControlNormalAttributes, for: .normal)
        sexSegmentedControl.setTitleTextAttributes(model.segmentedControlSelectedAttributes, for: .selected)
    }

}
