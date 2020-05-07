//
//  NewsModuleNewsModuleInteractorInput.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

import Foundation

protocol NewsModuleInteractorInput {
    func getNewsData(onSuccess: @escaping (MozambiqueNewsAPIResponse) -> (),
                     onFailure: @escaping (String) -> ()?)
}
