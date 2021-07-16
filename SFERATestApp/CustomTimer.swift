//
//  TimerStruct.swift
//  SFERATestApp
//
//  Created by Anton Yaroshchuk on 16.07.2021.
//

import Foundation

class CustomTimer{
    
    var name: String
    var amountOfTime: Int
    var countdownTimer: Timer
    var countDownText: String = ""
    var isPaused: Bool = false
    var dateFormatter: DateFormatter
    
    init(name: String, amountOfTime: Int) {
        self.name = name
        self.amountOfTime = amountOfTime
        countdownTimer = Timer()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown(){
        if amountOfTime == 0{
            countdownTimer.invalidate()
        } else {
            let minutes = (amountOfTime/60)%60
            let seconds = amountOfTime%60
            
            switch (minutes, seconds) {
            case(10...59, 10...59):
                countDownText = "\(minutes):\(seconds)"
            case(10...59, 0...9):
                countDownText = "\(minutes):0\(seconds)"
            case(0...9, 0...9):
                countDownText = "0\(minutes):0\(seconds)"
            case(0...9, 10...59):
                countDownText = "0\(minutes):\(seconds)"
            default:
                countDownText = "None"
            }
            amountOfTime -= 1
            
        }
    }
    
    @objc func pauseTimer(){
        if !isPaused{
            countdownTimer.invalidate()
            isPaused = true
        } else {
            isPaused = false
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        }
    }
}
