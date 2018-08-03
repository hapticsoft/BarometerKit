//
//  BarometerKitTests.swift
//  BarometerKitTests
//
//  Created by Bruno Godbout on 2018-08-01.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import XCTest
import os

@testable import BarometerKit



class BarometerSimulator: Barometer {

    var currentPressure: BarometricPressure?
    
    static private func randomPressure() -> NSNumber {
        return NSNumber(value: arc4random_uniform(100))
    }
    
    var timer: Timer?
    
    func start(onPressureChange pressureChanged: @escaping (BarometricPressure) -> Void) {
        
        // Start background task that calls the delegate at fixed intervals.
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self](t) in
            self?.currentPressure = BarometricPressure(kPa: BarometerSimulator.randomPressure())
            
            DispatchQueue.main.async {
                pressureChanged((self?.currentPressure)!)
            }
        }

        self.timer?.fire()
    }
    
    func stop() {
        
        // Terminate the background task
        self.timer?.invalidate()
        
    }
}

class BarometerTestFactory {
    func create() -> Barometer {
        var barometer: Barometer
        
        #if targetEnvironment(simulator)
        
        // There is no support for the iPhone Altimeter in the simulators, so we use our own.
        os_log("Using Simulated barometer", log: .default, type: .debug)
        barometer = BarometerSimulator()
        
        #else
        
        os_log("Using iPhone barometer", log: .default, type: .debug)
        barometer = PhoneBarometer()
        
        #endif
        
        return barometer
    }
}

class BarometerKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBarometerDelegatePressureChanged() {
        let expectation = XCTestExpectation(description: "Barometer Delegate method pressureChanged should be called at least 2 times.")
        expectation.expectedFulfillmentCount = 2
        
        let barometer = BarometerTestFactory().create()
        barometer.start() { newValue in
            os_log("testBarometerDelegatePressureChanged: %f", log: OSLog.default, type: .debug,  newValue.kPa.floatValue)
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 60 seconds.
        wait(for: [expectation], timeout: 60.0)
        
    }

    
}
