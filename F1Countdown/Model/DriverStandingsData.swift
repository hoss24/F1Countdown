//
//  FormulaData.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/27/21.
//

import Foundation
//use to format data
struct DriverStandingsData: Codable{
    let MRData: MRData
}

struct MRData: Codable {
    let total: String
    let StandingsTable: StandingsTable
}

struct StandingsTable: Codable{
    let season: String
    let StandingsLists: [StandingsLists]
}

struct StandingsLists: Codable{
    let DriverStandings: [DriverStandings]
}

struct DriverStandings: Codable{
    let points: String
    let wins: String
    let position: String
    let Driver: Driver
    let Constructors: [Constructors]
}
//MRData.StandingsTable.StandingsLists[0].DriverStandings[0].Driver.givenName == first place driver given name
struct Driver: Codable{
    let givenName: String
    let familyName: String
}

struct Constructors: Codable{
    let name: String
}
