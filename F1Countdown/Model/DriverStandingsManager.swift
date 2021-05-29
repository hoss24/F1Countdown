//
//  DataManager.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/27/21.
//

import Foundation

protocol DriverStandingsManagerDelegate{
    func didUpdateDriverStandings(_ driverStandingsManager: DriverStandingsManager, driverStandings: [DriverStandingsModel])
    func didFailWithError(error: Error)
}

struct DriverStandingsManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: DriverStandingsManagerDelegate?
    
    func fetchData(year: String) {
        let urlString = "\(dataURL)\(year)/driverStandings.json"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //parse data from JSON format
                    if let driverStandings = parseJSON(safeData){
                        //want to send back to standingsViewController but not tie to specific
                        delegate?.didUpdateDriverStandings(self, driverStandings: driverStandings)
                        //wvc is delegate
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ driverStandingsDataJSON: Data) -> [DriverStandingsModel]?{
        //create instance of JSONDecoder, dedicated to converting between JSON and Codable Objects
        let decoder = JSONDecoder()
        //.decode method to convert json data into a petitions object
        //throws so use try to see if it worked
        //.self refers to DriverStandingsData type rather than an instance... Not saying "create a new one" instead specifying as parameter to the decoding so JSONDecoder knows what to convert the JSON too
        do{
            let decodedData = try decoder.decode(DriverStandingsData.self, from: driverStandingsDataJSON)
            var driverStandingsModel = [DriverStandingsModel]()
            for driver in decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings {
                let position = driver.position
                let points = driver.points
                let givenName = driver.Driver.givenName
                let familyName = driver.Driver.familyName
                let teamName = driver.Constructors[0].name
                let driverStanding = DriverStandingsModel(position: position, points: points, givenName: givenName, familyName: familyName, teamName: teamName)
                driverStandingsModel.append(driverStanding)
            }
            return driverStandingsModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
