//
//  SpaceRocketModel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

struct SpaceRocketModel: Decodable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    let wikipedia: String
    let welcome3Description, id: String
}

struct Diameter: Decodable {
    let meters, feet: Double?
}

struct Engines: Decodable {
    let isp: ISP
    let thrustSeaLevel, thrustVacuum: Thrust
    let number: Int
    let type, version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1, propellant2: String
    let thrustToWeight: Double
}

struct ISP: Decodable {
    let seaLevel, vacuum: Int
}

struct Thrust: Decodable {
    let kN, lbf: Int
}

struct FirstStage: Decodable {
    let thrustSeaLevel, thrustVacuum: Thrust
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

struct LandingLegs: Decodable {
    let number: Int
    let material: String?
}

struct Mass: Decodable {
    let kg, lb: Int
}

struct PayloadWeight: Decodable {
    let id, name: String
    let kg, lb: Int
}

struct SecondStage: Decodable {
    let thrust: Thrust
    let payloads: Payloads
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

struct Payloads: Decodable {
    let compositeFairing: CompositeFairing
    let option1: String
}

struct CompositeFairing: Decodable {
    let height, diameter: Diameter
}
