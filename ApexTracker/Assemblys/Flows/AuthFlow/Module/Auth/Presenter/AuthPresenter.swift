//
//  AuthAuthPresenter.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

class AuthPresenter: AuthModuleInput {

    weak var view: AuthViewInput!
    var interactor: AuthInteractorInput!
    var router: AuthRouterInput!

    
}

extension AuthPresenter: AuthViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func loginWithSessionInfo(withSessionInfo sessionInfo: SessionInfo) {
        
    }
}

extension AuthPresenter: AuthInteractorOutput {
    
}
