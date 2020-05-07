//
//  NewsModuleNewsModuleInteractor.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 25/04/2020.
//  Copyright © 2020 me. All rights reserved.
//

class NewsModuleInteractor: NewsModuleInteractorInput {
    
    weak var output: NewsModuleInteractorOutput!
    private var networkService: MozambiqueHereNetworkManager! = MozambiqueHereNetworkManager()
    
    func getNewsData(onSuccess: @escaping (MozambiqueNewsAPIResponse) -> (), onFailure: @escaping (String) -> ()?) {
        networkService.getNews { (response, error) in
            if let response = response {
                onSuccess(response)
            } else {
                onFailure(error!)
            }
        }
    }

}
