//
//  AddPhotoView.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class AddPhotoView: UIView {

    // MARK: - Subviews

    private lazy var avatarImageView = UIImageView().with {
        $0.contentMode = .scaleAspectFill
        let configuration = UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: 100))
        $0.image = UIImage.withName("human10")
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(avatarImageViewTapGesture)
        $0.layer.cornerRadius = self.avatarButtonLength / 2
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
    }

    private lazy var plusButton = UIButton(type: .system).with {
        $0.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        $0.tintColor = colorManager.tabBar
    }

    // MARK: - Computing properties
    var didPressBannerImageView: Observable<Void> {
        return avatarImageViewTapGesture.rx.event.map { _ in }.asObservable()
    }

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let avatarButtonLength: CGFloat = 100
    private let avatarImageViewTapGesture = UITapGestureRecognizer()
    var reuseBag = DisposeBag()

    // MARK: - Binding
    private func bindObservable() {

    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        bindObservable()
        addSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }

    private func layout() {
        avatarImageView.pin
            .size(avatarButtonLength)
            .horizontally()

//        plusButton.pin
//            .size(30)
//            .left(to: avatarImageView.edge.right)
//            .marginLeft(16)
    }

    // MARK: - Private methods
    private func addSubview() {
        addSubviews([
            avatarImageView,
//            plusButton
        ])
    }

    func downloadAccountImage(with url: URL?) {
        guard let url = url else {
            return
        }
        avatarImageView.sd_setImage(with: url)
    }

    func configure(with image: UIImage) {
        avatarImageView.image = image
    }

}
