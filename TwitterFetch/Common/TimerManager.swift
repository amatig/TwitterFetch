//
//  TimerManager.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate : class {
    
    func pull()
}

protocol TimerManagerProtocol {
    func updateTimer(seconds: Int)
    func stopTimer()
}

class TimerManager: TimerManagerProtocol {
    
    weak var delegate: TimerManagerDelegate?
    var timer = Timer()
    var seconds: Int = 0
    
    func updateTimer(seconds: Int) {
        timer.invalidate()
        self.seconds = seconds
        runTimer()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}

fileprivate extension TimerManager {
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
    }
    
    @objc func loop() {
        self.delegate?.pull()
    }
}
