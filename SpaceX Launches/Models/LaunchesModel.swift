//
//  LaunchesModel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

struct LaunchesModel: Decodable {
    let docs: [Doc]
//    let totalDocs, offset, limit, totalPages: Int?
//    let page, pagingCounter: Int?
//    let hasPrevPage, hasNextPage: Bool?
}

struct Doc: Decodable {
    let fairings: Fairings?
    let links: Links?
    let static_fire_date_utc: String?
    let static_fire_date_unix: Int?
    let net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
//    let failures: [Failure?]
    let details: String?
//    let crew, ships, capsules: [String?]
//    let payloads: [String?]
    let launchpad: String?
    let flight_number: Int?
    let name, date_utc: String?
    let date_unix: Int?
//    let date_local: Date?
    let date_precision: String?
    let upcoming: Bool?
//    let cores: [Core?]
    let auto_update, tbd: Bool?
    let id: String?
}

struct Core: Decodable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landing_attempt: Bool?
    let landing_success, landing_type, landpad: String?
}

struct Failure: Decodable {
    let time: Int?
    let altitude: Int?
    let reason: String?
}

struct Fairings: Decodable {
    let reused, recovery_attempt, recovered: Bool?
    let ships: [String?]
}

struct Links: Decodable {
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let presskit: String?
    let webcast: String?
    let youtube_id: String?
    let article: String?
    let wikipedia: String?
}

struct Flickr: Decodable {
    let small, original: [String?]
}

struct Patch: Decodable {
    let small, large: String?
}

struct Reddit: Decodable {
    let campaign, launch, media, recovery: String?
}
