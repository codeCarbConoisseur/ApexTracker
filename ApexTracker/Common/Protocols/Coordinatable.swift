//
//  Coordinatable.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 29.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

protocol Coordinatable: class {
  func start()
  func start(with option: DeepLinkOption?)
}
