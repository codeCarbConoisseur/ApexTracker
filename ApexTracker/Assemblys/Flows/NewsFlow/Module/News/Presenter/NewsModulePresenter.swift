//
//  NewsModuleNewsModulePresenter.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

class NewsModulePresenter: NewsModuleModuleInput, NewsModuleViewOutput, NewsModuleInteractorOutput {
    

    weak var view: NewsModuleViewInput!
    var interactor: NewsModuleInteractorInput!
    var router: NewsModuleRouterInput!

    func viewIsReady() {

    }
}
