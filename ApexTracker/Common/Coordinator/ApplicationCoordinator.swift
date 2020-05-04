//
//  ApplicationCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 28.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

//fileprivate var onboardingWasShown = false
//fileprivate var isAutorized = false
//
//fileprivate enum LaunchInstructor {
//  case profile, auth
//
//  static func configure(isAutorized: Bool = isAutorized) -> LaunchInstructor {
//    if isAutorized {
//        return .profile
//    } else {
//        return .auth
//    }
//  }
//}

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let storage: UserDefaults = UserDefaults.standard
    private var userSessionManager: UserSessionController
    
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.userSessionManager = UserSessionController(storage: TokensStorage(storage: self.storage))
    }
    
    override func start(with option: DeepLinkOption?) {
        runMainFlow(withDeeplinkOption: option, withUserSessionManager: userSessionManager)
        //start with deepLink
//        if let option = option {
//            switch option {
//            case .onboarding: runOnboardingFlow()
//            case .signUp: runAuthFlow()
//            default: childCoordinators.forEach { coordinator in
//                coordinator.start(with: option)
//                }
//            }
//            // default start
//        } else {
//            switch instructor {
//            case .onboarding: runOnboardingFlow()
//            case .auth: runAuthFlow()
//            case .main: runMainFlow()
//            }
//        }
    }
    
    private func runMainFlow(withDeeplinkOption deepLinkOption: DeepLinkOption?, withUserSessionManager userSessionManager: UserSessionController) {
        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator(withDeepLinkOption: deepLinkOption, withSessionManager: userSessionManager, withCoordinatorFactory: coordinatorFactory)
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }
}
