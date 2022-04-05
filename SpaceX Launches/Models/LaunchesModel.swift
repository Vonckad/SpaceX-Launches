//
//  LaunchesModel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

struct LaunchesModel: Decodable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int?
    let rocket: Rocket
    let success: Bool?
    let failures: [Failure]
    let details: String?
    let crew, ships, capsules, payloads: [String]
    let launchpad: Launchpad
    let flightNumber: Int
    let name, dateUTC: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate, tbd: Bool
    let launchLibraryID: String?
    let id: String
}

struct Core: Decodable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: LandingType?
    let landpad: Landpad?
}

enum LandingType: Decodable {
    case asds
    case ocean
    case rtls
}

enum Landpad: Decodable {
    case the5E9E3032383Ecb267A34E7C7
    case the5E9E3032383Ecb554034E7C9
    case the5E9E3032383Ecb6Bb234E7CA
    case the5E9E3032383Ecb761634E7Cb
    case the5E9E3032383Ecb90A834E7C8
    case the5E9E3033383Ecb075134E7CD
    case the5E9E3033383Ecbb9E534E7Cc
}

enum DatePrecision: Decodable {
    case day
    case hour
    case month
    case quarter
}

struct Failure: Decodable {
    let time: Int
    let altitude: Int?
    let reason: String
}

struct Fairings: Decodable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [String]
}

enum Launchpad: Decodable {
    case the5E9E4501F509094Ba4566F84
    case the5E9E4502F509092B78566F87
    case the5E9E4502F509094188566F88
    case the5E9E4502F5090995De566F86
}

struct Links: Decodable {
    let patch: Patch
    let reddit: Reddit
//    let flickr: Flickr
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?
}

//struct Flickr: Decodable {
//    let small: [Any?]
//    let original: [String]
//}

struct Patch: Decodable {
    let small, large: String?
}

struct Reddit: Decodable {
    let campaign: String?
    let launch: String?
    let media, recovery: String?
}

enum Rocket: Decodable {
    case the5E9D0D95Eda69955F709D1Eb
    case the5E9D0D95Eda69973A809D1Ec
    case the5E9D0D95Eda69974Db09D1Ed
}
