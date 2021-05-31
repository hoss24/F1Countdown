//
//  ScheduleManager.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/29/21.
//

import Foundation

protocol ScheduleManagerDelegate{
    func didUpdateSchedule(_ scheduleManager: ScheduleManager, schedule: [ScheduleModel])
    func didFailWithError(error: Error)
}

struct ScheduleManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: ScheduleManagerDelegate?
    
    func fetchData(year: String) {
        let urlString = "\(dataURL)\(year).json"
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
                    if let schedule = parseJSON(safeData){
                        //want to send back to standingsViewController but not tie to specific
                        delegate?.didUpdateSchedule(self, schedule: schedule)
                        //wvc is delegate
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ scheduleDataJSON: Data) -> [ScheduleModel]?{
        //create instance of JSONDecoder, dedicated to converting between JSON and Codable Objects
        let decoder = JSONDecoder()
        //.decode method to convert json data into a petitions object
        //throws so use try to see if it worked
        //.self refers to ScheduleData type rather than an instance... Not saying "create a new one" instead specifying as parameter to the decoding so JSONDecoder knows what to convert the JSON too
        do{
            let decodedData = try decoder.decode(ScheduleData.self, from: scheduleDataJSON)
            var scheduleModel = [ScheduleModel]()
            for race in decodedData.MRData.RaceTable.Races {
                let date = race.date
                let time = race.time
                let raceName = race.raceName
                let locality = race.Circuit.Location.locality
                let country = race.Circuit.Location.country
                let schedule = ScheduleModel(date: date, time: time, raceName: raceName, locality: locality, country: country)
                scheduleModel.append(schedule)
            }
            return scheduleModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
