//
//  AuthFlowCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 04.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

final class AuthFlowCoordinator: BaseCoordinator, AuthFlowCoordinatorOutput {
    
    // MARK: AuthFlowCoordinatorOutput
    var onAuth: ((UserSession) -> Void)?
    
    // MARK: Properties:
    private let factory: AuthFlowFactory
    private let router: Routable
    
    init(flowFactory: AuthFlowFactory, router: Routable) {
        self.factory = flowFactory
        self.router = router
    }
    
    override func start() {
        showAuth()
    }
    
    private func showAuth() {
        var authOutput = factory.makeAuthOutput()
        authOutput.onSignInTapped = { [weak self] userSession in
            self?.onAuth?(userSession)
        }
        router.setRootModule(authOutput)
    }
    
}

