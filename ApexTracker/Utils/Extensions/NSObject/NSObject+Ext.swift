//
//  NSObject+Ext.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 16.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

