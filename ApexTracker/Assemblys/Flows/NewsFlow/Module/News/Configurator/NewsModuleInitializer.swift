//
//  NewsModuleNewsModuleInitializer.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class NewsModuleModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var newsmoduleViewController: NewsModuleViewController!

    override func awakeFromNib() {
        let configurator = NewsModuleModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: newsmoduleViewController)
    }

}
