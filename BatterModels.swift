//
//  Batter.swift
//  BBO
//
//  Created by 楊曜安 on 2024/2/4.
//

import Foundation

struct BatterResponse: Codable {
    let records:[Batter]
    let offset: String?
}

struct Batter: Codable {
    var id: String?
    var createdTime: String?
    var fields: BatterInfo
}

struct BatterInfo: Codable {
    let name: String
    let year: String
    let league: String
    let position: [String]
    let potential: [String]
    let veteranPotential: String
    let power: Int
    let contact: Int
    let speed: Int
    let throwing: Int
    let defense: Int
    let totalValue: Int
    let weatherAttribute: String
    let veteranWeatherAttribute: String?
    let upgradeType: String
    let battingHand: String
    let team: String
    let rarity: String
    let specialStance: Bool?
    var level: String?
    var createdTime: String?
    var addLineup: String?
    var selectedPotential: String?
}
