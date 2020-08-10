//
//  StandardButton.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 07.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift

class StandardButton: UIButton {

    // MARK: - Constants
    private let colorManager = DIContainer.colorManager

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String?, backgroundColor: UIColor? = DIContainer.colorManager.n1) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        configure()
    }

    // MARK: - Override Functions
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }

    private func layout() {
        if let titleLabel = titleLabel {
            titleLabel.pin.center()
            imageView?.pin
                .after(of: titleLabel)
                .marginLeft(Margin.x8)
        }
        addShadow(shouldSetPath: true, radius: 10, opacity: 0.5, color: colorManager.staticBlack.cgColor)
    }

    // MARK: - Private Methods
    private func configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(colorManager.n14, for: .normal)
    }

}

