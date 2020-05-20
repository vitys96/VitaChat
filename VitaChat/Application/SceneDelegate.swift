//
//  AppDelegate.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 21.04.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

//        let firestoreService = DIContainer.firestoreService
        
//        if let user = Auth.auth().currentUser {
//            firestoreService.getUserData(user: user) { result in
//                switch result {
//                case .success(let appUser):
//                    let mainTabBar = TabBarController(currentUser: appUser)
//                    mainTabBar.modalPresentationStyle = .fullScreen
//                    mainTabBar.configure(screens:[
////                        (.people, ProfileBuilder.build()),
////                        (.conversations, ProfileBuilder.build())
//                    ])
//                    self.window?.rootViewController = mainTabBar
//                case .failure:
//                    self.window?.rootViewController = AuthBuilder.build()
//                }
//            }
//        } else {
//        let mainTabBar = TabBarController()
//        mainTabBar.configure(screens: [
//            (.people, PeopleBuilder.build()),
//            (.conversations, ConversationsBuilder.build())
//        ])
        self.window?.rootViewController = ChatRequestBuilder.build()
//        window?.rootViewController = mainTabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

