//
//  StandingsViewController.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/27/21.
//

import UIKit

class StandingsViewController: UITableViewController{
    
    
    var driverStandingsManager = DriverStandingsManager()
    var driverStandingsLoaded = [DriverStandingsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        driverStandingsManager.delegate = self
        driverStandingsManager.fetchData(year: "2021")
        
        tableView.register(UINib(nibName: "StandingCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return driverStandingsLoaded.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StandingCell
        
        cell.positionView.layer.cornerRadius = 30
        cell.positionLabel.text = driverStandingsLoaded[indexPath.row].position
        
        cell.driverView.layer.borderWidth = 1
        cell.driverView.layer.borderColor = driverStandingsLoaded[indexPath.row].teamTextColor.cgColor
        cell.driverView.backgroundColor = driverStandingsLoaded[indexPath.row].teamColor
        cell.teamLabel.text = driverStandingsLoaded[indexPath.row].teamName
        cell.teamLabel.textColor = driverStandingsLoaded[indexPath.row].teamTextColor
        cell.driverLabel.text = driverStandingsLoaded[indexPath.row].name
        cell.driverLabel.textColor = driverStandingsLoaded[indexPath.row].teamTextColor
        
        cell.pointsLabel.text = driverStandingsLoaded[indexPath.row].points

    
        //cell.textLabel?.text = driverStandingsLoaded[indexPath.row]
        return cell
    }

}

extension StandingsViewController: DriverStandingsManagerDelegate{
    func didUpdateDriverStandings(_ driverStandingsManager: DriverStandingsManager, driverStandings: [DriverStandingsModel]) {
        DispatchQueue.main.async {
            for driver in driverStandings {
                self.driverStandingsLoaded.append(driver)
                self.tableView.reloadData()
            }
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


