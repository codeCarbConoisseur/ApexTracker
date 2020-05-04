//
//  TabBarView.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 29.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

protocol TabbarView {
    var onNewsFlowSelect: ((UINavigationController) -> ())? { get set }
    var onProfileFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
