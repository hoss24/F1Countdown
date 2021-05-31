//
//  FormulaStandingsModel.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/27/21.
//

import Foundation
import UIKit

struct DriverStandingsModel{
    let position: String
    let points: String
    
    let givenName: String
    let familyName: String
    var name: String {
        return givenName + " " + familyName
    }
    
    let teamName: String
    
    //computedProperty, work out its value based on code inside curly braces
    var teamColor: UIColor{
        switch teamName {
        case "Red Bull":
            return UIColor(rgb: 0x0600EF)
        case "Mercedes":
            return UIColor(rgb: 0x00D2BE)
        case "McLaren":
            return UIColor(rgb: 0xFF8700)
        case "Ferrari":
            return UIColor(rgb: 0xDC0000)
        case "AlphaTauri":
            return UIColor(rgb: 0x2B4562)
        case "Alpine F1 Team":
            return UIColor(rgb: 0x0090FF)
        case "Aston Martin":
            return UIColor(rgb: 0x006F62)
        case "Alfa Romeo":
            return UIColor(rgb: 0x900000)
        case "Williams":
            return UIColor(rgb: 0x005AFF)
        case "Haas F1 Team":
            return UIColor(rgb: 0xFFFFFF)
        default:
            return UIColor(rgb: 0x0600EF)
        }
    }
    
    var teamTextColor: UIColor{
        switch teamName {
        case "Haas F1 Team":
            return UIColor(rgb: 0x000000)
        default:
            return UIColor(rgb: 0xFFFFFF)
        }
    }
    
}


