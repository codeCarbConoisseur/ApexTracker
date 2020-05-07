//
//  NewsModuleNewsModuleViewOutput.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

protocol NewsModuleViewOutput {

    /**
        @author sofvckinmadguy
        Notify presenter that view is ready
    */

    func getData(completion: @escaping (_ response: MozambiqueNewsAPIResponse?)->())
    func viewIsReady()
}
