//
//  URLFactory.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 22.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

class SpecialURLFactory {
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func buildURLWithSpecialPath(path: SpecialPath) -> URL {
        switch path {
        case .allProfileStats(let platform, let userId):
            let pathComponent: String = "/" + platform + "/" + userId
            return baseURL.appendingPathComponent(pathComponent)
        case .profileSegment(let platform, let userId, let segment):
            let pathComponent: String = "/" + platform + "/" + userId + "/segments/" + segment
            return baseURL.appendingPathComponent(pathComponent)
        case .matchHistory(let platform, let userId):
            let pathComponent: String = "/" + platform + "/" + userId + "/sessions"
            return baseURL.appendingPathComponent(pathComponent)
        }
    }
}
