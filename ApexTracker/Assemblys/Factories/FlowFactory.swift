//
//  ModuleFactory.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 01.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

final class FlowFactory: NewsFlowFactory, ProfileFlowFactory, AuthFlowFactory {
    
    
    
    static let shared = FlowFactory()
    
    init() {}
    
    func makeNewsOutput() -> NewsViewCoordinatorOutput {
        return NewsModuleViewController.controllerFromStoryboard(.newsFlow)
    }
    
    func makeProfileOutput() -> ProfileViewCoordinatorOutput {
        return ProfileSectionViewController.controllerFromStoryboard(.profileFlow)
    }
    
    func makeAuthOutput() -> AuthViewCoordinatorOutput {
        return AuthViewController.controllerFromStoryboard(.authFlow)
    }
    
}
