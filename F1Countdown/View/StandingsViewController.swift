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
    var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.delegate = self
        driverStandingsManager.delegate = self
        tableView.register(UINib(nibName: "StandingCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        driverStandingsLoaded = []
        driverStandingsManager.fetchData(year: "2021")
        loadingView.showUniversalLoadingView(true, loadingText: "Loading...")
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
        return cell
    }
}

extension StandingsViewController: DriverStandingsManagerDelegate{
    func didUpdateDriverStandings(_ driverStandingsManager: DriverStandingsManager, driverStandings: [DriverStandingsModel]) {
        DispatchQueue.main.async {
            for driver in driverStandings {
                self.driverStandingsLoaded.append(driver)
                self.tableView.reloadData()
                self.loadingView.hideLoading()
            }
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension StandingsViewController: LoadingViewDelegate {
    func didCreateLoadingView(_ loadingView: UIView) {
        view.addSubview(loadingView)
    }
    func finishLoadingView(_ existingView: UIView?) {
        existingView?.removeFromSuperview()
    }
}


