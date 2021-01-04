//
//  HumanProfileViewModel.swift
//  VitaChat
//
//  Created by Vitaly on 03.01.2021.
//  Copyright © 2021 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

struct HumanProfileViewModel {

    let id: String
    let name: NSAttributedString
    let aboutInfo: NSAttributedString
    
    init(with user: AppUser) {
        let colorManager = DIContainer.colorManager
        
        id = user.id
        name = user.username.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
        aboutInfo = user.description.addAttributes(fontStyle: .regular, size: 18, color: colorManager.n1)
    }
    
}
