//
//  PeopleCollectionCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import RxSwift
import Kingfisher

class PeopleCollectionCell: UICollectionViewCell {

    // MARK: - Subviews
    private let containerView = ShadowContainerView()
    private let imageView = UIImageView().with {
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    private let userNameLabel = UILabel()

    // MARK: - Protocol propeties
    private let colorManager = DIContainer.colorManager

    // MARK: - Properties
    var reuseBag = DisposeBag()

    // MARK: - Computed properties

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        reuseBag = DisposeBag()
        imageView.kf.cancelDownloadTask()
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    private func layout() {
        containerView.pin.all()

        imageView.pin
            .top()
            .horizontally()
            .height(contentView.frame.width)

        userNameLabel.pin
            .horizontally(Margin.x2)
            .bottom(to: containerView.edge.bottom)
            .marginBottom(Margin.x2)
            .sizeToFit()

        contentView.pin.height(containerView.frame.maxY + Margin.x2)
    }

    // MARK: - Public methods
    func setup(with model: PeopleViewModel) {
        imageView.kf.setImage(with: model.userImageUrl)
        userNameLabel.attributedText = model.username

        setNeedsLayout()
    }

    // MARK: - Private methods
    private func addSubviews() {
        containerView.addSubviews([
            imageView,
            userNameLabel,
        ])

        contentView.addSubview(containerView)
    }

}
