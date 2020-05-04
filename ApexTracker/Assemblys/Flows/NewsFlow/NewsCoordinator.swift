//
//  NewsCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 01.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

final class NewsCoordinator: BaseCoordinator, NewsCoordinatorOutput {
    
    // MARK: Properties:
    private let factory: NewsFlowFactory
    private let router: Routable
    
    init(flowFactory: NewsFlowFactory, router: Routable) {
        self.factory = flowFactory
        self.router = router
    }
    
    override func start() {
        
    }
    
    private func showNews() {
        var newsOutput = factory.makeNewsOutput()
        newsOutput.onItemSelected = { [weak self] id in
            self?.showNewsDetail(withId: id)
        }
        router.setRootModule(newsOutput)
    }
    
    private func showNewsDetail(withId: Int) {
        
    }
    
    
}
