//
//  NewsModuleNewsModuleViewController.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import UIKit

class NewsModuleViewController: UIViewController, NewsModuleViewInput, NewsViewCoordinatorOutput {
    
    // MARK: NewsViewCoordinatorOutput
    var onItemSelected: ((Int) -> Void)?
    
    // MARK: Properties:
    var output: NewsModuleViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: NewsModuleViewInput
    func setupInitialState() {
    }
}


extension NewsModuleViewController {    
    
}
