//
//  Deeplink.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 28.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

struct DeepLinkURLConstants {
    static let Auth = "auth"
    static let News = "items"
    static let NewsItem = "item"
    static let Profile = "settings"
    static let ProfileSegment = "login"
}

enum DeepLinkOption {
    
    case auth
    case news
    case profile
    case profileSegment(String?)
    case newsItem(String?)
    
    static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            //TODO: extract string and match with DeepLinkURLConstants
        }
        return nil
    }
    
    static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
        guard let id = dict?["launch_id"] as? String else { return nil }
        
        let newsItemID = dict?["newsItem_id"] as? String
        let profileSegmentID = dict?["profileSegment_id"] as? String
        
        switch id {
        case DeepLinkURLConstants.Auth: return .auth
        case DeepLinkURLConstants.News: return .news
        case DeepLinkURLConstants.NewsItem: return .newsItem(newsItemID)
        case DeepLinkURLConstants.Profile: return .profile
        case DeepLinkURLConstants.ProfileSegment: return .profileSegment(profileSegmentID)
        default: return nil
        }
    }
}




