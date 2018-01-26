//
//  TimerManagerTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 13/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TimerManagerTests: XCTestCase {
    
    var timerManager : TimerManager!
    
    override func setUp() {
        super.setUp()
        timerManager = TimerManager()
    }
    
    override func tearDown() {
        timerManager = nil
        super.tearDown()
    }
    
    func test_WhenUpdateTimer_ThenTimerIsNotNil() {
        timerManager.updateTimer(seconds: 60)
        
        XCTAssertNotNil(timerManager.timer)
    }
    
    func test_WhenStopTimer_ThenTimerIsInvalidated() {
        timerManager.updateTimer(seconds: 60)
        timerManager.stopTimer()
        
        XCTAssertEqual(timerManager.timer.isValid, false)
    }
    
    func test_GivenTimerRunning_WhenUpdateTimer_ThenTimerUpdated() {
        timerManager.updateTimer(seconds: 30)
        timerManager.updateTimer(seconds: 300)
        
        XCTAssertNotNil(timerManager.timer)
        XCTAssertEqual(300, timerManager.seconds)
    }
}
