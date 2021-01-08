//
//  ChatRequestViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 20.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import UIKit

final class ChatRequestViewController: BaseViewController {

    // MARK: - Subviews
    private lazy var containerView = UIView().with {
        $0.backgroundColor = colorManager.n13
    }
    private let imageView = UIImageView().with {
        $0.image = UIImage.withName("human2")
        $0.contentMode = .scaleAspectFill
    }
    private let nameLabel = UILabel().with {
        $0.textColor = .black
//        $0.text = "jkwhd Mdqjwhd"
    }
    private let aboutMeLabel = UILabel().with {
        $0.textColor = .black
//        $0.text = "jkwhd Mdqjwhd"
    }
    private let acceptButton = GradientButton().with {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.setTitle("ПРИНЯТЬ", for: .normal)
    }
    private let denyButton = UIButton().with {
        $0.setTitleColor(.red, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.setupBorder(withColor: UIColor.red.withAlphaComponent(0.4), andWidth: 1)
        $0.setTitle("ОТКЛОНИТЬ", for: .normal)
    }

    // MARK: - Protocol properties
    private let output: ChatRequestViewOutput

    // MARK: - Properties
     private let colorManager = DIContainer.colorManager

    // MARK: - Init
    init(output: ChatRequestViewOutput) {
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

        bindObservable()
        output.viewDidLoad()
    }

    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layout()
    }

    private func layout() {
        let bottomButtonHeight: CGFloat = 45

        containerView.pin
            .bottom()
            .height(206)
            .horizontally()

        imageView.pin
            .top()
            .horizontally()
            .bottom(to: containerView.edge.top)
            .marginBottom(-30)

        nameLabel.pin
            .top(Margin.x8)
            .horizontally(Margin.x6)
            .sizeToFit()

        aboutMeLabel.pin
            .below(of: nameLabel)
            .marginTop(8)
            .horizontally(Margin.x6)
            .sizeToFit()

        acceptButton.pin
            .height(bottomButtonHeight)
            .width(45%)
            .below(of: aboutMeLabel)
            .bottom(view.pin.safeArea.bottom)
            .marginTop(Margin.x4)
            .left(10)

        denyButton.pin
            .height(bottomButtonHeight)
            .after(of: acceptButton, aligned: .center)
            .right(10)
            .marginLeft(10)
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            imageView,
            containerView
        ])
        containerView.addSubviews([
            nameLabel,
            aboutMeLabel,
            acceptButton,
            denyButton
        ])
    }

}

// MARK: - ChatRequestViewInput
extension ChatRequestViewController: ChatRequestViewInput {

    func showRequestChatData(with model: ChatRequestViewModel) {
        imageView.kf.setImage(with: model.userImageUrl)
        nameLabel.attributedText = model.username

        view.setNeedsLayout()
    }

}
