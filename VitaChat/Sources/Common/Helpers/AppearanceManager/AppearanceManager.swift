//
//  AppearanceManager.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class AppearanceManager: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        configureNavigationBar()
        configureTableView()

        return true
    }

    private func configureNavigationBar() {
        let colorManager = DIContainer.colorManager
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = colorManager.n1
        UINavigationBar.appearance().barTintColor = colorManager.n13
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: colorManager.n1]
//        UINavigationBar.appearance().backIndicatorImage = UIImage.withName("BackNavigationImage")
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage.withName("BackNavigationImage")
    }

    private func configureTableView() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableViewCell.appearance().selectionStyle = .none
    }

}
