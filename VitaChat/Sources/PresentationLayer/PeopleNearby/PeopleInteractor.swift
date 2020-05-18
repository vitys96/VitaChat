//
//  PeopleInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

final class PeopleInteractor {

    // MARK: - Protocol properties
    weak var output: PeopleInteractorOutput?

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Init
    init() {}

    // MARK: - Private methods

}

// MARK: - PeopleInteractorInput
extension PeopleInteractor: PeopleInteractorInput {}
