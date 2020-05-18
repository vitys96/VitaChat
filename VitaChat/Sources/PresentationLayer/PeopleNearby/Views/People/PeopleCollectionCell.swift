//
//  PeopleCollectionCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import RxSwift

class PeopleCollectionCell: UICollectionViewCell {

    // MARK: - Subviews
    private let containerView = UIView()

    private let imageView = UIImageView()

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

    }

    // MARK: - Public methods
    func setup(with model: PeopleViewModel) {

        imageView.image = UIImage.withName(model.userImageString)
        userNameLabel.attributedText = model.username

        setNeedsLayout()
    }

    // MARK: - Private methods
    private func addSubviews() {

        contentView.addSubviews([
            containerView,
        ])
        containerView.addSubviews([
            imageView,
            userNameLabel,
        ])

    }

    private func configure() {
        self.layer.cornerRadius = 4

        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

}

