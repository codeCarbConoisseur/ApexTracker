//
//  BaseCoordinator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 28.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import CoreData
import Foundation

class BaseCoordinator: Coordinatable {

  var childCoordinators: [Coordinatable] = []
  
  func start() {
    start(with: nil)
  }
  
  func start(with option: DeepLinkOption?) { }
  
  // add only unique object
  func addDependency(_ coordinator: Coordinatable) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
  }
  
  func removeDependency(_ coordinator: Coordinatable?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
      else { return }
    
    // Clear child-coordinators recursively
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
        coordinator.childCoordinators
            .filter({ $0 !== coordinator })
            .forEach({ coordinator.removeDependency($0) })
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
        childCoordinators.remove(at: index)
        break
    }
  }
}
