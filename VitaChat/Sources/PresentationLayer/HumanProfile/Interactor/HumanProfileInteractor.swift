//
//  HumanProfileInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class HumanProfileInteractor {

    // MARK: - Protocol properties
    weak var output: HumanProfileInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - HumanProfileInteractorInput
extension HumanProfileInteractor: HumanProfileInteractorInput {}
