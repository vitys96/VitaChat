//
//  SectionHeader.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionViewCell {

    // MARK: - Subviews
    private lazy var titleLabel = UILabel()

    // MARK: - Protocol poperties
    private let colorManager = DIContainer.colorManager

    // MARK: - Computed properties

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func setup(title: String) {
        titleLabel.attributedText = title.addAttributes(fontStyle: .regular, size: 20, color: colorManager.n12)

        setNeedsLayout()
    }

}
