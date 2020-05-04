//
//  ProfileEndPoint.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 21.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

enum TrackerGGNetworkEnvironment {
    case main
}

public enum TrackerGGApi {
    case allProfileStats
    case profileSegment
    case searchPlayer(String, String)
    case matchHistory
}

enum TrackerGGPlatform: String {
    case origin = "origin"
    case playstation = "psn"
    case xbox = "xbl"
    case battleNet = "battlenet"
}

extension TrackerGGApi: EndPointType {
    
    var environmentBaseURL : String {
        switch TrackerGGNetworkManager.environment {
        case .main: return "https://public-api.tracker.gg/v2/apex/standard"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .searchPlayer:
            return "/search"
        default:
            return "/profile"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .searchPlayer(let platform, let userId):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["platform": platform, "query": userId], additionHeaders: headers!)
        default:
            return .requestHeaders(additionHeaders: headers!)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["TRN-Api-Key": TrackerGGNetworkManager.TrackerGGApiKey]
    }
}


