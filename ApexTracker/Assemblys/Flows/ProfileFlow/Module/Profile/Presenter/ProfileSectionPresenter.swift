//
//  ProfileSectionProfileSectionPresenter.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

class ProfileSectionPresenter: ProfileSectionModuleInput, ProfileSectionViewOutput, ProfileSectionInteractorOutput {

    weak var view: ProfileSectionViewInput!
    var interactor: ProfileSectionInteractorInput!
    var router: ProfileSectionRouterInput!

    func viewIsReady() {

    }
}
