//
//  ShadowContainerView.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 24.10.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ShadowContainerView: UIView {

    private var shadowRadius: CGFloat = 8
    private var offsetY: CGFloat = 10
    private var cornerRadius: CGFloat = 12

    // MARK: - Init
    init(shadowRadius: CGFloat = 8, offsetY: CGFloat = 10, cornerRadius: CGFloat = 12) {
        self.shadowRadius = shadowRadius
        self.offsetY = offsetY
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)

        configure()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addShadow(shouldSetPath: true, radius: shadowRadius,
                  opacity: 0.1, offset: CGSize(width: 0, height: offsetY))
    }

    // MARK: - Private methods
    private func configure() {
        backgroundColor = DIContainer.colorManager.n15
        layer.cornerRadius = cornerRadius
    }

}
