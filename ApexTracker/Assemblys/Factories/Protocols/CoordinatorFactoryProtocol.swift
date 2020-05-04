//
//  CoordinatorFactoryProtocol.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 29.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit.UINavigationController

protocol CoordinatorFactoryProtocol {
    
     func makeTabbarCoordinator(withDeepLinkOption deepLinkOption: DeepLinkOption?, withSessionManager sessionManager: UserSessionController, withCoordinatorFactory coordinatorFactory: CoordinatorFactoryProtocol) -> (configurator: Coordinatable, toPresent: Presentable?)
    
    func makeProfileCoordinator() -> Coordinatable
    func makeProfileCoordinator(navController: UINavigationController?) -> Coordinatable & ProfileFlowCoordinatorOutput
    func makeProfileCoordinator(router: Routable) -> Coordinatable & ProfileFlowCoordinatorOutput
    
    func makeAuthFlowCoordinator() -> Coordinatable
    func makeAuthFlowCoordinator(navController: UINavigationController?) -> Coordinatable & AuthFlowCoordinatorOutput
    func makeAuthFlowCoordinator(router: Routable) -> Coordinatable & AuthFlowCoordinatorOutput
    
    func makeNewsCoordinator() -> Coordinatable
    func makeNewsCoordinator(navController: UINavigationController?) -> Coordinatable
    func makeNewsCoordinator(router: Routable) -> Coordinatable & NewsCoordinatorOutput
    
//    func makeAuthCoordinator() -> Coordinatable
    
}
