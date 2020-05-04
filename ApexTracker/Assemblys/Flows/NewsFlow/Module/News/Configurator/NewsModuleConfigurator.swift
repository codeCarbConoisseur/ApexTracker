//
//  NewsModuleNewsModuleConfigurator.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class NewsModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NewsModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NewsModuleViewController) {

        let router = NewsModuleRouter()

        let presenter = NewsModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NewsModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
