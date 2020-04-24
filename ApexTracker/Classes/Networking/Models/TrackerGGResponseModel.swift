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
    let availableSegments: [AvailableSegment]
    let expiryDate: Date
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
    let additionalParameters: JSONNull?

    enum CodingKeys: String, CodingKey {
        case platformSlug
        case platformUserID = "platformUserId"
        case platformUserHandle, platformUserIdentifier
        case avatarURL = "avatarUrl"
        case additionalParameters
    }
}

// MARK: - Segment
struct Segment: Codable {
    let type: String
    let attributes: SegmentAttributes
    let metadata: SegmentMetadata
    let expiryDate: Date
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
    let category: JSONNull?
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
    let rank: JSONNull?
    let percentile: Int
    let displayName: String
    let displayCategory: DisplayCategory
    let category: JSONNull?
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
    let userID: JSONNull?
    let isPremium, isVerified, isInfluencer: Bool
    let countryCode: String
    let customAvatarURL, customHeroURL: JSONNull?
    let socialAccounts: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case isPremium, isVerified, isInfluencer, countryCode
        case customAvatarURL = "customAvatarUrl"
        case customHeroURL = "customHeroUrl"
        case socialAccounts
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
