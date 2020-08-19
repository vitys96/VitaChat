//
//  CameraManagerProtocol.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 18.08.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

protocol CameraManagerProtocol {

    func showActionSheet(vc: UIViewController, completion: ((UIImage?) -> Void)?)

}
