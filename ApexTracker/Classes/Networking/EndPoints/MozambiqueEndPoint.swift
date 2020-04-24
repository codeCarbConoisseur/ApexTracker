//
//  NewsEndPoint.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 20.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

enum MozambiqueNetworkEnvironment {
    case mozambiqueHere
}

enum MozambiquePlatform: String {
    case pc = "PC"
    case ps = "PS4"
    case xbox = "X1"
}

public enum MozambiqueHereApi {
    case allNews
    case playerStats(String, String)
}

extension MozambiqueHereApi: EndPointType {
    
    var environmentBaseURL : String {
        switch MozambiqueHereNetworkManager.environment {
        case .mozambiqueHere: return "https://api.mozambiquehe.re"
        }
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .playerStats:
            return "/bridge"
        case .allNews:
            return "/news"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .allNews:
            return .requestHeaders(additionHeaders: headers!)
        case .playerStats(let platform, let player):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["platform": platform, "player": player], additionHeaders: headers!)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": MozambiqueHereNetworkManager.MozambiqueApiKey]
    }
}


