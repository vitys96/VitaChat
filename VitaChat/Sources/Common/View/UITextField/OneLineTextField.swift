//
//  OneLineTextField.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 03.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

class OneLineTextField: UITextField {

    // MARK: - Subviews
    private lazy var bottomView = UIView().with {
        $0.backgroundColor = colorManager.n12.withAlphaComponent(0.3)
    }

    // MARK: - Constants
    private let colorManager = DIContainer.colorManager

    // MARK: - Properties
    var textInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

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

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    private func layout() {

        bottomView.pin
            .horizontally()
            .height(1)
            .bottom(-5)
    }

    // MARK: - Private methods
    private func addSubview() {
        addSubview(bottomView)
    }

}
