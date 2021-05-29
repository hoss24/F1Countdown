//
//  StandingCell.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/28/21.
//

import UIKit

class StandingCell: UITableViewCell {
    @IBOutlet var positionView: UIView!
    @IBOutlet var driverView: UIView!
    @IBOutlet var pointsView: UIView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var driverLabel: UILabel!
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
