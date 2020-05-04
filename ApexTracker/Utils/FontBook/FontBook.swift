//
//  FontBook.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 16.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//


import UIKit

enum FontBook: String {
    
    case DukeFill = "Duke-Fill"
    
    case BlocktasticItalic = "Blocktastic-Italic"
    case BlocktasticIregular = "Blocktastic"
    
    case ApexMk2Bold = "ApexMk2-BoldExtended"
    case ApexMk2LightCondensed = "ApexMk2-LightCondensed"
    case ApexMk2Regular = "ApexMk2-Regular"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    
}

