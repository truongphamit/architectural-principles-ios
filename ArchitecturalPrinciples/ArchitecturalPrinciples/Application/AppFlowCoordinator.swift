//
//  AppFlowCoordinator.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 28/09/2022.
//

import UIKit

final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let actions = MainViewControllerActions(
            showUIKit: showUIKit
        )
        let viewController = appDIContainer.createMainViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showUIKit() {
        let viewController = appDIContainer.createUIKitViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
