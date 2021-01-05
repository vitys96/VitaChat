//
//  AddPhotoView.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import RxSwift

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
    var didPressAvatarImage: Observable<Void> {
        return avatarImageViewTapGesture.rx.event.map { _ in }.asObservable()
    }

    var avatrDidChange: Observable<UIImage> {
        return selectedPhotosSubject.asObservable()
    }

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let avatarButtonLength: CGFloat = 100
    private let avatarImageViewTapGesture = UITapGestureRecognizer()
    private let selectedPhotosSubject = PublishSubject<UIImage>()

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
    }

    private func layout() {
        avatarImageView.pin
            .size(avatarButtonLength)
            .horizontally()
    }

    // MARK: - Private methods
    private func addSubview() {
        addSubviews([
            avatarImageView,
        ])
    }

    func downloadAccountImage(with url: URL?) {
        guard let url = url else {
            return
        }
        avatarImageView.kf.setImage(with: url, completionHandler: { result in
            if case let .success(image) = result {
                self.selectedPhotosSubject.onNext(image.image)
            }
        })
    }

    func configure(with image: UIImage) {
        avatarImageView.image = image
    }

}
