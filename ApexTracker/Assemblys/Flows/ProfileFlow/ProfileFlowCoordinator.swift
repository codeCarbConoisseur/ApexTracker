//
//  ProfileFlowCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 04.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

final class ProfileFlowCoordinator: BaseCoordinator, ProfileFlowCoordinatorOutput {
    // MARK: ProfileFlowCoordinatorOutput
    var onSignOut: ((UserSession) -> Void)?
    
    // MARK: Properties:
    private let factory: ProfileFlowFactory
    private let router: Routable
    
    init(flowFactory: ProfileFlowFactory, router: Routable) {
        self.factory = flowFactory
        self.router = router
    }
    
    override func start(withUserSession userSession: UserSession) {
        showProfile(withUserSession: userSession)
    }
    
    private func showProfile(withUserSession userSession: UserSession) {
        var profileOutput = factory.makeProfileOutput()
        profileOutput.onLegendSelect = { [weak self] legend in
            self?.showLegendDetail(withName: legend)
        }
        profileOutput.onSignOutTappped = { [weak self] userSession in
            self?.signOut(withUserSession: userSession)
        }
        router.setRootModule(profileOutput)
    }
    
    private func showLegendDetail(withName name: String) {
        
    }
    
    private func signOut(withUserSession userSession: UserSession) {
        
    }
    
}
