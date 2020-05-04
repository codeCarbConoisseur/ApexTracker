//
//  NewsModuleFactoryProtocol.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 01.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

protocol NewsFlowFactory {
    
    func makeNewsOutput() -> NewsViewCoordinatorOutput
}
