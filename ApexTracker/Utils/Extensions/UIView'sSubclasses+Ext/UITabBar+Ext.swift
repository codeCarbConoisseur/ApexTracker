//
//  UITabBar+Ext.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 16.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import UIKit

extension UITabBar {
    func setBackgroundImage(_ image: UIImage, yOffset: Int) {
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        let tabBarView = UIImageView(image: image)
        tabBarView.frame = CGRect(x: 0, y: yOffset, width: Int(tabBarView.bounds.width), height: Int(tabBarView.bounds.height))
        self.addSubview(tabBarView)
        self.sendSubviewToBack(tabBarView)
    }
}
