//
//  TrackerGGResponseModel.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 22.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

struct TrackerProfileResponse: Codable {
    let data: DataModel
}

// MARK: - DataClass
struct DataModel: Codable {
    let platformInfo: PlatformInfo
    let userInfo: UserInfo
    let metadata: DataMetadata
    let segments: [Segment]
//    let availableSegments: [AvailableSegment]
//    let expiryDate: Date
}

// MARK: - AvailableSegment
struct AvailableSegment: Codable {
    let type: String
    let attributes: MetadataClass
}

// MARK: - MetadataClass
struct MetadataClass: Codable {
}

// MARK: - DataMetadata
struct DataMetadata: Codable {
    let currentSeason: Int
    let activeLegend, activeLegendName: String
}

// MARK: - PlatformInfo
struct PlatformInfo: Codable {
    let platformSlug, platformUserID, platformUserHandle, platformUserIdentifier: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case platformSlug
        case platformUserID = "platformUserId"
        case platformUserHandle, platformUserIdentifier
        case avatarURL = "avatarUrl"
    }
}

// MARK: - Segment
struct Segment: Codable {
    let type: String
//    let attributes: SegmentAttributes
    let metadata: SegmentMetadata
//    let expiryDate: Date
    let stats: Stats
}

// MARK: - SegmentAttributes
struct SegmentAttributes: Codable {
    let id: String?
}

// MARK: - SegmentMetadata
struct SegmentMetadata: Codable {
    let name: String
    let imageURL, tallImageURL: String?
    let bgImageURL: String?
    let isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "imageUrl"
        case tallImageURL = "tallImageUrl"
        case bgImageURL = "bgImageUrl"
        case isActive
    }
}

// MARK: - Stats
struct Stats: Codable {
    let level: Damage?
    let kills: Damage
    let killsPerMatch, damage, matchesPlayed, seasonWINS: Damage?
    let seasonDamage: Damage
    let rankScore: RankScore?
    let encoreExecutionsEscaped: Damage?

    enum CodingKeys: String, CodingKey {
        case level, kills, killsPerMatch, damage, matchesPlayed
        case seasonWINS = "seasonWins"
        case seasonDamage, rankScore, encoreExecutionsEscaped
    }
}

// MARK: - Damage
struct Damage: Codable {
    let rank: Int?
    let percentile: Double?
    let displayName: String
    let displayCategory: DisplayCategory
    let metadata: MetadataClass
    let value: Double
    let displayValue: String
    let displayType: DisplayType
}

enum DisplayCategory: String, Codable {
    case combat = "Combat"
    case game = "Game"
}

enum DisplayType: String, Codable {
    case unspecified = "Unspecified"
}

// MARK: - RankScore
struct RankScore: Codable {
    let percentile: Int
    let displayName: String
    let displayCategory: DisplayCategory
    let metadata: RankScoreMetadata
    let value: Int
    let displayValue: String
    let displayType: DisplayType
}

// MARK: - RankScoreMetadata
struct RankScoreMetadata: Codable {
    let iconURL: String
    let rankName: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "iconUrl"
        case rankName
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let isPremium, isVerified, isInfluencer: Bool?
    let countryCode: String?
    let customAvatarURL, customHeroURL: String?

    enum CodingKeys: String, CodingKey {
        case isPremium, isVerified, isInfluencer, countryCode
        case customAvatarURL = "customAvatarUrl"
        case customHeroURL = "customHeroUrl"
    }
}

