//
//  AddPhotoView.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

class AddPhotoView: UIView {

    // MARK: - Subviews
    lazy var avatarButton = UIButton().with {
        $0.imageView?.contentMode = .scaleAspectFit
        let configuration = UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: 100))
        let image = UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: configuration)
        $0.setImage(image, for: .normal)
        $0.tintColor = colorManager.tabBar
    }

    // MARK: - Constants
    private let colorManager = DIContainer.colorManager

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
        avatarButton.layer.masksToBounds = true
    }

    private func layout() {

        avatarButton.pin.all()
    }

    // MARK: - Private methods
    private func addSubview() {
        addSubview(avatarButton)
    }

}
