//
//  AuthAuthConfigurator.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class AuthModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AuthViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AuthViewController) {

        let router = AuthRouter()

        let presenter = AuthPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AuthInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
