//
//  NewsModuleNewsModulePresenter.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

class NewsModulePresenter: NewsModuleModuleInput {
    
    weak var view: NewsModuleViewInput!
    var interactor: NewsModuleInteractorInput!
    var router: NewsModuleRouterInput!

    
}

extension NewsModulePresenter: NewsModuleViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func getData(completion: @escaping (_ response: MozambiqueNewsAPIResponse?)->()) {
        let onSuccess: (MozambiqueNewsAPIResponse) -> Void = { [weak self] data in
            self?.view.activityViewStopAnimating()
            completion(data)
        }
        let onFailure: (String) -> Void = { [weak self] error in
            self?.view.activityViewStopAnimating()
            self?.view.showAlert(title: "Error", message: error, buttonTitle: "OK", handler: nil)
        }
        self.interactor.getNewsData(onSuccess: onSuccess, onFailure: onFailure)
    }
}

extension NewsModulePresenter: NewsModuleInteractorOutput {
    
}
