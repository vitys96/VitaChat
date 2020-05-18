//
//  ActiveChatsCollectionCell.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import PinLayout
import RxSwift

class ActiveChatsCollectionCell: UICollectionViewCell {

    // MARK: - Subviews
    private let imageView = UIImageView()

    private let userNameLabel = UILabel()

    private let lastMessageLabel = UILabel()

    private let gradientView = GradientView().with {
        $0.setupGradient(from: .topTrailing, to: .bottomLeading)
    }

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

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }

    private func layout() {
        let imageViewSize: CGFloat = contentView.frame.height

        imageView.pin
            .size(imageViewSize)
            .vCenter()

        userNameLabel.pin
            .after(of: imageView)
            .marginLeft(10)
            .top()
            .marginTop(10)
            .sizeToFit()

        lastMessageLabel.pin
            .below(of: userNameLabel)
            .left(to: userNameLabel.edge.left)
            .before(of: gradientView)
            .marginTop(10)
            .sizeToFit()


        gradientView.pin
            .right()
            .height(imageViewSize)
            .width(8)
    }

    // MARK: - Public methods
    func setup(with model: ConversationCellViewModel) {

        imageView.image = UIImage.withName(model.userImageString)
        userNameLabel.attributedText = model.username
        lastMessageLabel.attributedText = model.lastMessage

        setNeedsLayout()
    }

    // MARK: - Private methods
    private func addSubviews() {

        contentView.addSubviews([
            imageView,
            userNameLabel,
            lastMessageLabel,
            gradientView
        ])

    }

    private func configure() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }

}
