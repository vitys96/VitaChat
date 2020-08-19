//
//  AppDelegate.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 21.04.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        DIContainer.colorManager.setup(
            n1: UIColor(named: "n1"),
            n2: UIColor(named: "n2"),
            n3: UIColor(named: "n3"),
            n4: UIColor(named: "n4"),
            n5: UIColor(named: "n5"),
            n6: UIColor(named: "n6"),
            n7: UIColor(named: "n7"),
            n8: UIColor(named: "n8"),
            n9: UIColor(named: "n9"),
            n10: UIColor(named: "n10"),
            n11: UIColor(named: "n11"),
            n12: UIColor(named: "n12"),
            n13: UIColor(named: "n13"),
            n14: UIColor(named: "n14"),
            staticWhite: UIColor(named: "staticWhite"),
            staticBlack: UIColor(named: "staticBlack"),
            tabBar: UIColor(named: "tabBar")
        )
        setupMainWindow()

        DIContainer.appDelegates.forEach {
            _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }

        return true
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: - Private methods
    private func setupMainWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let userService = DIContainer.userService
//
//        if let user = userService.getUser() {
//            let tabBarController = TabBarController()
//            tabBarController.configure(screens: [
//                (.conversations, ConversationsBuilder.build(with: user)),
//                (.people, PeopleBuilder.build(with: user))
//            ])
//            window?.rootViewController = tabBarController
//        } else {
//            let viewController = AuthBuilder.build()
//            window?.rootViewController = viewController
//        }
        window?.rootViewController = ProfileBuilder.build(with: ProfileContext(user: nil))
        window?.makeKeyAndVisible()
    }

}

