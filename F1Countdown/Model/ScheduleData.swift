//
//  ScheduleData.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/29/21.
//

import Foundation

struct ScheduleData: Codable{
    let MRData: MRDataSchedule
}

struct MRDataSchedule: Codable {
    //schedule data
    let RaceTable: RaceTable
}

//schedule data
struct RaceTable: Codable{
    let Races: [Races]
}

struct Races: Codable{
    let date: String
    let time: String
    let raceName: String
    let Circuit: Circuit
}

struct Circuit: Codable{
    let Location: Location
}

struct Location: Codable{
    let locality: String
    let country: String
}
