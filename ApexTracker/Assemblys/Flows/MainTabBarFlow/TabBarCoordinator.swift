//
//  TabBarCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 29.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation
import UIKit


// таб бар не должен хранить ссылку на вью!
//он должен конформить протоколу через который он будет получать триггеры с таб бар контроллера!!!
//  и конфигюр таб бар должен быть в таб бар контроллере

class TabbarCoordinator: BaseCoordinator {
       
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let deepLinkOption: DeepLinkOption?
    private let userSessionManager: UserSessionController
    private var tabBarOutput: TabbarView
    
    init(coordinatorFactory: CoordinatorFactoryProtocol, deepLinkOption: DeepLinkOption?, userSessionManager: UserSessionController, tabBarFlowOutput: TabbarView) {
        self.coordinatorFactory = coordinatorFactory
        self.deepLinkOption = deepLinkOption
        self.userSessionManager = userSessionManager
        self.tabBarOutput = tabBarFlowOutput
    }
    
    override func start(with option: DeepLinkOption?) {
        if let option = option {
            switch option {
            case .news:
                break
            case .profile:
                break
            default:
                childCoordinators.forEach { coordinator in
                    coordinator.start(with: option)
                }
            }
        } else {
            let userSession = userSessionManager.userSession
            switch userSession.state {
            case .closed:
                startWithOption(withUserSessionInfo: userSession.userSessionInfo)
            case .initialized:
                if userSessionManager.canRestorePreviousSession() {
                    userSession.startSession(with: userSession.userSessionInfo!)
                } else {
                    userSessionManager.closeSession()
                }
                startWithOption(withUserSessionInfo: userSession.userSessionInfo)
            case .opened:
                startWithOption(withUserSessionInfo: userSession.userSessionInfo)
            }
        }
    }
    
    private func startWithOption(withUserSessionInfo userSessionInfo: SessionInfo?) {
        tabBarOutput.onViewDidLoad = runNewsFlow()
        tabBarOutput.onNewsFlowSelect = runNewsFlow()
        if let sessionInfo = userSessionInfo {
            tabBarOutput.onProfileFlowSelect = runProfileFlow(withUserSession: sessionInfo)
        } else {
            tabBarOutput.onProfileFlowSelect = runAuthFlow()
        }
    }
    
    
    private func runNewsFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let newsCoordinator = self.coordinatorFactory.makeNewsCoordinator(navController: navController)
                self.addDependency(newsCoordinator)
                newsCoordinator.start()
            }
        }
    }
    
    private func runProfileFlow(withUserSession userSession: SessionInfo) -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            //if navController.viewControllers.isEmpty == true {
                var profileCoordinator = self.coordinatorFactory.makeProfileCoordinator(navController: navController)
                profileCoordinator.onSignOut = { [weak self] userSession in
                    userSession.stopSession()
                    self?.start(with: nil)
                    self?.removeDependency(profileCoordinator)
                }
            self.addDependency(profileCoordinator)
                profileCoordinator.start()
                
            //}
        }
    }
    
    private func runAuthFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navController in
            var authCoordinator = self.coordinatorFactory.makeAuthFlowCoordinator(navController: navController)
            authCoordinator.onAuth = { [weak self] userSession in
                if let sessionInfo = userSession.userSessionInfo {
                    userSession.startSession(with: sessionInfo)
                                   self?.start(with: nil)
                                   self?.removeDependency(authCoordinator)
                } else {
                    self?.start(with: nil)
                }
            }
            self.addDependency(authCoordinator)
            authCoordinator.start()
            
        }
    }
}
