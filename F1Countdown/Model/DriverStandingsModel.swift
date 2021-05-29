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
    
    var positionInt: Int? {
        return Int(position)
    }
    var pointsInt: Int? {
        return Int(points)
    }
    
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

//MARK: - Hex Color Converter
//color conversion from hex #______ to UIColor
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
