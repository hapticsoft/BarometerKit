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
    var delegate: BarometerDelegate?
    var currentPressure: NSNumber = 0.0
    
    static private func randomPressure() -> NSNumber {
        return NSNumber(value: arc4random_uniform(100))
    }
    
    lazy var timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self](t) in
        self?.currentPressure = BarometerSimulator.randomPressure()
        
        DispatchQueue.main.async {
            self?.delegate?.pressureChanged(to: (self?.currentPressure)!)
        }
    }
    
    func start() {
        
        // Start background task that calls the delegate at fixed intervals.
        
        self.timer.fire()
    }
    
    func stop() {
        
        // Terminate the background task
        self.timer.invalidate()
        
    }
}

class BarometerDelegateTester : BarometerDelegate {
    var callbackClosure : ((_ pressure: NSNumber) -> Void)?
    var pressureChangedWasCalled = false
    var lastPressureReading : NSNumber = 0
    
    func pressureChanged(to: NSNumber) {
        pressureChangedWasCalled = true
        lastPressureReading = to
        callbackClosure?(lastPressureReading)
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
    
    var barometerDelegate: BarometerDelegateTester?
    
    override func setUp() {
        super.setUp()
        barometerDelegate = BarometerDelegateTester()
    }
    
    override func tearDown() {
        barometerDelegate = nil
        super.tearDown()
    }

    func testBarometerDelegatePressureChanged() {
        let expectation = XCTestExpectation(description: "Barometer Delegate method pressureChanged should be called at least 2 times.")
        expectation.expectedFulfillmentCount = 2
        
        barometerDelegate?.callbackClosure = { pressure in
            os_log("Pressure=%f", log: OSLog.default, type: .error, pressure.floatValue)
            expectation.fulfill()
        }
        var barometer = BarometerTestFactory().create()
        barometer.delegate = barometerDelegate
        barometer.start()
        
        // Wait until the expectation is fulfilled, with a timeout of 60 seconds.
        wait(for: [expectation], timeout: 60.0)
        
    }

    
}
