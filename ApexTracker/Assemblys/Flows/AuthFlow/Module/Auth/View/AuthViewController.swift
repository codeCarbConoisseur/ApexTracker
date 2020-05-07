//
//  AuthAuthViewController.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, AuthViewInput, AuthViewCoordinatorOutput {
    
    // MARK: AuthViewCoordinatorOutput
    var onSignInTapped: ((UserSession) -> Void)?
    
    // MARK: Properties:
    var output: AuthViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: AuthViewInput
    func setupInitialState() {
        
    }
}


extension AuthViewController: NavigationBarConfigurationProtocol {
    
}
