//
//  ProfileSectionProfileSectionInitializer.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class ProfileSectionModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var profilesectionViewController: ProfileSectionViewController!

    override func awakeFromNib() {

        let configurator = ProfileSectionModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: profilesectionViewController)
    }

}
