//
//  HumanProfileViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift

final class HumanProfileViewController: BaseViewController {
    
    // MARK: - Subviews
    private lazy var containerView = UIView().with {
        $0.backgroundColor = colorManager.n13
    }
    private let imageView = UIImageView().with {
        $0.contentMode = .scaleAspectFill
    }
    private let nameLabel = UILabel().with {
        $0.textColor = .black
    }
    private let aboutMeLabel = UILabel().with {
        $0.textColor = .black
    }
    private lazy var textField = InsertableTextField().with {
        $0.backgroundColor = DIContainer.colorManager.n11
        $0.placeholder = "Напишите что-нибудь..."
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.clearButtonMode = .whileEditing
        $0.borderStyle = .none
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.delegate = self
    }
    
    // MARK: - Protocol properties
    private let output: HumanProfileViewOutput
    
    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(output: HumanProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    private func bindObservable() {
        textField.didPressSendButton
            .subscribe(onNext: { [unowned self] in
                guard let text = textField.text, !text.isEmpty else {
                    return
                }
                self.output.didTapSendMesssage(message: text) })
            .disposed(by: disposeBag)
    }
    
    // MARK: Life cycle
    override func loadView() {
        view = UIView()
        addSubviews()
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindObservable()
        output.viewDidLoad()
    }
    
    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layout()
    }
    
    private func layout() {
        containerView.pin
            .bottom()
            .height(206)
            .horizontally()
        
        imageView.pin
            .top()
            .horizontally()
            .bottom(to: containerView.edge.top)
            .marginBottom(-30)
        
        nameLabel.pin
            .top(35)
            .horizontally(24)
            .sizeToFit()
        
        aboutMeLabel.pin
            .below(of: nameLabel)
            .marginTop(8)
            .horizontally(24)
            .sizeToFit()
        
        textField.pin
            .below(of: aboutMeLabel)
            .marginTop(8)
            .horizontally(24)
            .height(48)
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        view.addSubviews([
            imageView,
            containerView
        ])
        containerView.addSubviews([
            nameLabel,
            aboutMeLabel,
            textField
        ])
        setupActivityIndicator()
    }
    
}

// MARK: - HumanProfileViewInput
extension HumanProfileViewController: HumanProfileViewInput {
    
    func showData(with model: HumanProfileViewModel) {
        nameLabel.attributedText  = model.name
        aboutMeLabel.attributedText = model.aboutInfo
        imageView.kf.setImage(with: model.avatarStringURL)
        
        view.setNeedsLayout()
    }
    
}

// MARK: - UITextFieldDelegate
extension HumanProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
