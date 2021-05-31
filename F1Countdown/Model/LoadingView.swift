//
//  LoadingView.swift
//  F1Countdown
//
//  Created by Grant Matthias Hosticka on 5/30/21.
//

import Foundation
import UIKit

protocol LoadingViewDelegate{
    func didCreateLoadingView(_ loadingView: UIView)
    func finishLoadingView(_ existingView: UIView?)
}

struct LoadingView {
    
    var delegate: LoadingViewDelegate?
    
    //MARK: - Loading View
    func hideLoading(){
        showUniversalLoadingView(false)
    }
    func showUniversalLoadingView(_ show: Bool, loadingText : String = "") {
        let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
        if show {
            if existingView != nil {
                return
            }
            let loadingView = makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
            loadingView?.tag = 1200
            delegate?.didCreateLoadingView(loadingView!)
            
        } else {
            delegate?.finishLoadingView(existingView)
        }
        UIAccessibility.post(notification: .announcement, argument: "Loading")
    }
    func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = UIColor(rgb: 0xF0F3F4)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.tag = 100
        activityIndicator.accessibilityLabel = "Loading"

        loadingView.addSubview(activityIndicator)
        if !text!.isEmpty {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
            lbl.center = cpoint
            lbl.textColor = UIColor.black
            lbl.textAlignment = .center
            lbl.text = text
            lbl.tag = 1234
            loadingView.addSubview(lbl)
        }
        return loadingView
    }
    
}
