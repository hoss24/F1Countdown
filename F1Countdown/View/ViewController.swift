//
//  ViewController.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/27/21.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet var raceNameLabel: UILabel!
    @IBOutlet var localityCountryLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var daysRemainingLabel: UILabel!
    @IBOutlet var hoursRemainingLabel: UILabel!
    @IBOutlet var minutesRemainingLabel: UILabel!
    
    var scheduleManager = ScheduleManager()
    var scheduleLoaded = [ScheduleModel]()
    var loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scheduleManager.delegate = self
        loadingView.delegate = self
        scheduleManager.fetchData(year: "2021")
        loadingView.showUniversalLoadingView(true, loadingText: "Loading...")
    }
    func updateTimeRemaining(raceDate: Date) {
        let now = Date()
        let calendar = Calendar.current
        let diff = calendar.dateComponents([.hour, .minute, .second], from: now, to: raceDate)
        let hoursRemaining = diff.hour! % 24
        let daysRemaining = (diff.hour! - hoursRemaining) / 24
        let minutesRemaining = diff.minute!
        daysRemainingLabel.text = ("\(daysRemaining)")
        hoursRemainingLabel.text = ("\(hoursRemaining)")
        minutesRemainingLabel.text = ("\(minutesRemaining)")
    }
    


}

extension ViewController: ScheduleManagerDelegate{
    func didUpdateSchedule(_ scheduleManager: ScheduleManager, schedule: [ScheduleModel]) {
        DispatchQueue.main.async {
            for race in schedule {
                if race.dateTime > Date() {
                    self.raceNameLabel.text = race.raceName
                    self.localityCountryLabel.text = race.locality + ", " + race.country
                    self.dateTimeLabel.text = DateFormatter.localizedString(
                      from: race.dateTime,
                      dateStyle: .medium,
                      timeStyle: .medium)
                    self.updateTimeRemaining(raceDate: race.dateTime)
                    self.loadingView.hideLoading()
                    return
                }
            }
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: LoadingViewDelegate {
    func didCreateLoadingView(_ loadingView: UIView) {
        view.addSubview(loadingView)
    }
    func finishLoadingView(_ existingView: UIView?) {
        existingView?.removeFromSuperview()
    }
}
