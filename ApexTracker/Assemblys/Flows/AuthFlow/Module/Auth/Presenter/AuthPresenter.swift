//
//  AuthAuthPresenter.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

class AuthPresenter: AuthModuleInput, AuthViewOutput, AuthInteractorOutput {

    weak var view: AuthViewInput!
    var interactor: AuthInteractorInput!
    var router: AuthRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
}
