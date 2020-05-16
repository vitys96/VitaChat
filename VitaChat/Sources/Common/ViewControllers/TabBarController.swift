//
//  TabBarController.swift
//  VitaChat
//
//  Created by Okhrimenko Vitaliy on 04.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Properties
    let colorManager = DIContainer.colorManager
//    private let currentUser: AppUser

    // MARK: - Init
//    init() {
//        self.currentUser = currentUser
//        super.init(nibName: nil, bundle: nil)
//    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = colorManager.tabBar
        tabBar.isTranslucent = true
    }

    // MARK: - Public methods
    public func configure(screens: [(tab: TabItem, controller: UIViewController)]) {
        viewControllers = screens.map { (tab, controller) in
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.tabBarItem.title = tab.title
            navigationController.tabBarItem.image = tab.image
            return navigationController
        }
    }

}

extension TabBarController {

    public enum TabItem: String {

        case people
        case conversations

        var title: String {
            switch self {
            case .people:
                return "People"
            case .conversations:
                return "Conversations"
            }
        }

        var image: UIImage? {
            let configuration = UIImage.SymbolConfiguration(weight: .bold)
            switch self {
            case .people:
                return UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: configuration)
            case .conversations:
                return UIImage(systemName: "person.2", withConfiguration: configuration)
            }
        }

    }

}

