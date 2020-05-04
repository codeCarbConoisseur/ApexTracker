//
//  ProfileSectionProfileSectionViewController.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class ProfileSectionViewController: UIViewController, ProfileSectionViewInput, ProfileViewCoordinatorOutput {
    
    
    // MARK: ProfileViewCoordinatorOutput
    var onLegendSelect: ((String) -> Void)?
    var onSignOutTappped: ((UserSession) -> Void)?
    
    // MARK: Properties:
    var output: ProfileSectionViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    // MARK: ProfileSectionViewInput
    func setupInitialState() {
    }
}
