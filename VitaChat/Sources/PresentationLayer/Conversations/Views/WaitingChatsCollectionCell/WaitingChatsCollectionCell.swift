//
//  WaitingChatsCollectionCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 16.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import RxSwift

class WaitingChatsCollectionCell: UICollectionViewCell {

    // MARK: - Subviews
    private let imageView = UIImageView()

    // MARK: - Protocol propeties
    private let colorManager = DIContainer.colorManager

    // MARK: - Properties
    var reuseBag = DisposeBag()

    // MARK: - Computed properties

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        reuseBag = DisposeBag()
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    private func layout() {

        imageView.pin.all()
    }

    // MARK: - Public methods
    func setup(with model: ConversationCellViewModel) {

        imageView.image = UIImage.withName(model.userImageString)

        setNeedsLayout()
    }

    // MARK: - Private methods
    private func addSubviews() {

        contentView.addSubviews([
            imageView,
        ])

    }

    private func configure() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }

}
