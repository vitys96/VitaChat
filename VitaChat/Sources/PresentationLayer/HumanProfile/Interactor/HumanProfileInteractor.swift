//
//  HumanProfileInteractor.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 19.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift

final class HumanProfileInteractor {
    
    // MARK: - Protocol properties
    weak var output: HumanProfileInteractorOutput?
    private let firestoreService: FirestoreServiceProtocol
    private let userService: UserServiceProtocol
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(userService: UserServiceProtocol, firestoreService: FirestoreServiceProtocol) {
        self.userService = userService
        self.firestoreService = firestoreService
    }
    
    // MARK: - Private methods
    
}

// MARK: - HumanProfileInteractorInput
extension HumanProfileInteractor: HumanProfileInteractorInput {
    
    func createWaitingChat(user: AppUser, message: String) {
        guard let currentUser = userService.getUser() else {
            return
        }
        firestoreService.createWaitingChats(currentUser: currentUser, message: message, receiver: user)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [unowned self] in self.output?.chatRequestFetchedSuccessfully() },
                onError: { [unowned self] in self.output?.chatRequestFetched(with: $0) })
            .disposed(by: disposeBag)
    }
    
}
