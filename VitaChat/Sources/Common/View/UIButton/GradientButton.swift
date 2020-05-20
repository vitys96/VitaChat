//
//  GradientButton.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 20.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    // MARK: - Subviews
    private let gradientView = GradientView().with {
        $0.setupGradient(from: .topTrailing, to: .bottomLeading)
    }

    var isCentered = false {
        didSet {
            setNeedsLayout()
        }
    }

//    override var isHighlighted: Bool {
//        didSet {
//            UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
//                self.alpha = self.isHighlighted ? 0.5 : 1
//            }, completion: nil)
//        }
//    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview()
        moveImageViewToFront()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
    }

    private func layout() {
        let sizeLenght: CGFloat = 30

        imageView?.pin
            .size(sizeLenght)

        if isCentered {
            imageView?.pin.center()
        } else {
            titleLabel?.pin.center()
            imageView?.pin.right(Margin.x3)
        }

        adjustsImageWhenHighlighted = false
        gradientView.pin
            .all()
    }

    // MARK: - Public methods
    func setGradient(startColor: UIColor, endColor: UIColor) {
        gradientView.setupGradient(startColor: startColor, endColor: endColor)
    }

    // MARK: - Private methods
    private func addSubview() {
        addSubview(gradientView)
    }

    private func moveImageViewToFront() {
        if let imageView = imageView {
            bringSubviewToFront(imageView)
        }
    }

}
