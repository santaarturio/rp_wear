//
//  ANProgressView.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 15.11.2020.
//

import UIKit

class ANProgressView: UIProgressView {

    private var timer = Timer()
    private var progressFlag: Bool = true
    
    public func setup() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerSelector),
                                     userInfo: nil, repeats: true)
    }
    @objc func timerSelector() {
        if progressFlag {
            setProgress(1.0, animated: true)
        } else {
            setProgress(0.3, animated: true)
        }
        progressFlag = !progressFlag
    }

    public func complete() {
        timer.invalidate()
        setProgress(1.0, animated: true)
    }
}
