//
//  ProfileSectionProfileSectionConfigurator.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class ProfileSectionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ProfileSectionViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ProfileSectionViewController) {

        let router = ProfileSectionRouter()

        let presenter = ProfileSectionPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ProfileSectionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
