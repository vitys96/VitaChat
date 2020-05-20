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
        $0.text = "jkwhd Mdqjwhd"
    }
    private let aboutMeLabel = UILabel().with {
        $0.textColor = .black
        $0.text = "jkwhd Mdqjwhd"
    }
    private let acceptButton = GradientButton().with {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .white
        $0.roundWithShadow(cornerRadius: 10)
        $0.setTitle("ACCEPT", for: .normal)
    }
    private let denyButton = UIButton().with {
        $0.setTitleColor(.red, for: .normal)
        $0.backgroundColor = .white
        $0.roundWithShadow(cornerRadius: 10)
        $0.setupBorder(withColor: UIColor.red.withAlphaComponent(0.4), andWidth: 1)
        $0.setTitle("DENY", for: .normal)
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
        let widthInPercent = 44
        let outerMarginInPercent = 4
        let innerMarginInPercent = 100 - 2 * (widthInPercent + outerMarginInPercent)
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
            .width(widthInPercent%)
            .below(of: aboutMeLabel)
            .marginTop(Margin.x4)
            .left(outerMarginInPercent%)
            .bottom(view.pin.safeArea.bottom)

        denyButton.pin
            .height(bottomButtonHeight)
            .width(widthInPercent%)
            .right(outerMarginInPercent%)
            .after(of: acceptButton, aligned: .center)
            .marginLeft(innerMarginInPercent%)

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

    private func configure() {
        containerView.roundWithShadow(cornerRadius: 30, shadowRadius: 5)
    }

}

// MARK: - ChatRequestViewInput
extension ChatRequestViewController: ChatRequestViewInput {}
