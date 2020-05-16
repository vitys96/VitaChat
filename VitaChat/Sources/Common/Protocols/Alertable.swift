//
//  Alertable.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 05.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

protocol Alertable {

    func showErrorAlert(labelText: String?, detailText: String?)
    func showClosedErrorAlert(labelText: String?, detailText: String?, closedAction: @escaping (() -> Void))
    func showSuccessAlert(labelText: String?, detailText: String?)

}
