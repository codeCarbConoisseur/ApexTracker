//
//  AuthAuthInitializer.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class AuthModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var authViewController: AuthViewController!

    override func awakeFromNib() {

        let configurator = AuthModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: authViewController)
    }

}
