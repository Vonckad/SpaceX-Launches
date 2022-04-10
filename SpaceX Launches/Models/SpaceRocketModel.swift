//
//  SpaceRocketModel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

struct SpaceRocketModel: Decodable {
    let height, diameter: Diameter?
    let mass: Mass?
    let first_stage: FirstStage?
    let second_stage: SecondStage?
    let engines: Engines?
    let landing_legs: LandingLegs?
    let payload_weights: [PayloadWeight]?
    let flickr_images: [String]?
    let name, type: String?
    let active: Bool?
    let stages, boosters, cost_per_launch, success_rate_pct: Int?
    let first_flight, country, company: String?
    let wikipedia: String?
    let welcome3Description, id: String?
}

struct Diameter: Decodable {
    let meters, feet: Double?
}

struct Engines: Decodable {
    let isp: ISP?
    let thrust_sea_level, thrust_vacuum: Thrust?
    let number: Int?
    let type, version: String?
    let layout: String?
    let engine_loss_max: Int?
    let propellant_1, propellant_2: String?
    let thrust_to_weight: Double?
}

struct ISP: Decodable {
    let sea_level, vacuum: Int?
}

struct Thrust: Decodable {
    let kN, lbf: Int?
}

struct FirstStage: Decodable {
    let thrust_sea_level, thrust_vacuum: Thrust?
    let reusable: Bool?
    let engines: Int?
    let fuel_amount_tons: Double?
    let burn_time_sec: Int?
}

struct LandingLegs: Decodable {
    let number: Int?
    let material: String?
}

struct Mass: Decodable {
    let kg, lb: Int?
}

struct PayloadWeight: Decodable {
    let id, name: String?
    let kg, lb: Int?
}

struct SecondStage: Decodable {
    let thrust: Thrust?
    let payloads: Payloads?
    let reusable: Bool?
    let engines: Int?
    let fuel_amount_tons: Double?
    let burn_time_sec: Int?
}

struct Payloads: Decodable {
    let composite_fairing: CompositeFairing?
    let option_1: String?
}

struct CompositeFairing: Decodable {
    let height, diameter: Diameter?
}
