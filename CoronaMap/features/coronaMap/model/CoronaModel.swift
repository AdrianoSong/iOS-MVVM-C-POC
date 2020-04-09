//
//  CoronaModel.swift
//  CoronaMap
//
//  Created by Song on 06/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

//   let corona = try? newJSONDecoder().decode(Corona.self, from: jsonData)

// MARK: - Corona
struct Corona: Codable {
    let version: Int?
    let sourceURL: String?
    let country, lastUpdatedAtApify: String?
    let historyData, readMe: String?
    let tested, recovered, lastUpdatedAtSource: String?
    let infected, deceased: Int?
    let infectedByRegion, deceasedByRegion: [EdByRegion]?

    enum CodingKeys: String, CodingKey {
        case version
        case sourceURL = "sourceUrl"
        case country, lastUpdatedAtApify, historyData, readMe, tested, recovered,
        lastUpdatedAtSource, infected, deceased, infectedByRegion, deceasedByRegion
    }
}

// MARK: - EdByRegion
struct EdByRegion: Codable {
    let state: String?
    let count: Int?
}
