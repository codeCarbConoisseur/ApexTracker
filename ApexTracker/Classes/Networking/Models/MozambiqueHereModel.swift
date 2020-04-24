//
//  MozambiqueHereModel.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 20.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

struct MozambiqueNewsAPIResponseElement: Codable {
    let title: String
    let link: String
    let img: String
    let shortDesc: String

    enum CodingKeys: String, CodingKey {
        case title, link, img
        case shortDesc = "short_desc"
    }
}

typealias MozambiqueNewsAPIResponse = [MozambiqueNewsAPIResponseElement]
