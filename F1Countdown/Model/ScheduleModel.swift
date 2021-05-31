//
//  ScheduleModel.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/29/21.
//

import Foundation

struct ScheduleModel {
    let date: String //format 2021-03-28
    let time: String //format 15:00:00Z
    
    var dateTime: Date {
        // The default timeZone for ISO8601DateFormatter is UTC
        let utcISODateFormatter = ISO8601DateFormatter()
        
        // Parsing a string timestamp representing a date
        let dateString = date + "T" + time 
        let utcDate = utcISODateFormatter.date(from: dateString)

        // Return Date
        if let formattedDateTime = utcDate {
            return formattedDateTime
        } else {
            return Date()
        }
    }
    
    let raceName: String
    let locality: String
    let country: String
}
