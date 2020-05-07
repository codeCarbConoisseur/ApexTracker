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
    let appendingPath: String
    
    init(appendingPath: String,baseURL: URL) {
        self.baseURL = baseURL
        self.appendingPath = appendingPath
    }
    
    func buildURLWithSpecialPath(path: SpecialPath) -> URL {
        let url = baseURL.appendingPathComponent(appendingPath)
        switch path {
        case .allProfileStats(let platform, let userId):
            let pathComponent: String = "/" + platform + "/" + userId
            return url.appendingPathComponent(pathComponent)
        case .profileSegment(let platform, let userId, let segment):
            let pathComponent: String = "/" + platform + "/" + userId + "/segments/" + segment
            return url.appendingPathComponent(pathComponent)
        case .matchHistory(let platform, let userId):
            let pathComponent: String = "/" + platform + "/" + userId + "/sessions"
            return url.appendingPathComponent(pathComponent)
        }
    }
}
