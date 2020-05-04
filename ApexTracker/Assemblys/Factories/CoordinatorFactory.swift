//
//  CoordinatorFactory.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 29.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    static let shared = CoordinatorFactory()
    
    init() {}
    
    //    func makeAuthCoordinator() -> Coordinatable {
    //        let controller = TabbarController.controllerFromStoryboard(.main)
    //        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactory(), deepLinkOption: deepLinkOption, userSessionManager: sessionManager)
    //        return coordinator
    //    }
    //
    //
    //    func makeProfileCoordinator() -> Coordinatable {
    //        let controller = TabbarController.controllerFromStoryboard(.main)
    //        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactory(), deepLinkOption: deepLinkOption, userSessionManager: sessionManager)
    //        return coordinator
    //    }
    //
    //    func makeProfileCoordinator(navController: UINavigationController?) -> Coordinatable {
    //        let controller = TabbarController.controllerFromStoryboard(.main)
    //        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactory(), deepLinkOption: deepLinkOption, userSessionManager: sessionManager)
    //        return coordinator
    //    }
    
    func makeAuthFlowCoordinator() -> Coordinatable {
        let coordinator = makeAuthFlowCoordinator(navController: nil)
        return coordinator
    }
    
    func makeAuthFlowCoordinator(navController: UINavigationController?) -> AuthFlowCoordinatorOutput & Coordinatable {
        let coordinator = makeAuthFlowCoordinator(router: router(navController))
        return coordinator
    }
    
    func makeAuthFlowCoordinator(router: Routable) -> AuthFlowCoordinatorOutput & Coordinatable {
        let coordinator = AuthFlowCoordinator(flowFactory: FlowFactory.shared, router: router)
        return coordinator
    }
    
    func makeProfileCoordinator() -> Coordinatable {
        let coordinator = makeProfileCoordinator(navController: nil)
        return coordinator
    }
    
    func makeProfileCoordinator(navController: UINavigationController?) -> Coordinatable & ProfileFlowCoordinatorOutput{
        let coordinator = makeProfileCoordinator(router: router(navController))
        return coordinator
    }
    
    func makeProfileCoordinator(router: Routable) -> Coordinatable & ProfileFlowCoordinatorOutput {
        let coordinator = ProfileFlowCoordinator(flowFactory: FlowFactory.shared, router: router)
        return coordinator
    }
    
    func makeNewsCoordinator() -> Coordinatable {
        let coordinator = makeNewsCoordinator(navController: nil)
        return coordinator
    }
    
    func makeNewsCoordinator(navController: UINavigationController?) -> Coordinatable {
        let coordinator = makeNewsCoordinator(router: router(navController))
        return coordinator
    }
    
    func makeNewsCoordinator(router: Routable) -> Coordinatable & NewsCoordinatorOutput {
        let coordinator = NewsCoordinator(flowFactory: FlowFactory.shared, router: router)
        return coordinator
    }
    
    func makeTabbarCoordinator(withDeepLinkOption deepLinkOption: DeepLinkOption?, withSessionManager sessionManager: UserSessionController, withCoordinatorFactory coordinatorFactory: CoordinatorFactoryProtocol) -> (configurator: Coordinatable, toPresent: Presentable?) {
        let controller = TabbarController.controllerFromStoryboard(.tabBarFlow)
        let coordinator = TabbarCoordinator(coordinatorFactory: CoordinatorFactory.shared, deepLinkOption: deepLinkOption, userSessionManager: sessionManager, tabBarFlowOutput: controller)
        return (coordinator, controller)
    }
    
    private func router(_ navController: UINavigationController?) -> Routable {
        return Router(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController.controllerFromStoryboard(.main) }
    }
}
