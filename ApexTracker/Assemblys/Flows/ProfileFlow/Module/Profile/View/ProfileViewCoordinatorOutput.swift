//
//  ProfileViewCoordinatorOutput.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 04.05.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

protocol ProfileViewCoordinatorOutput: Presentable {
    var onLegendSelect: ((String) -> Void)? { get set }
    var onSignOutTappped: ((UserSession) -> Void)? { get set }
}
