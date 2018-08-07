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

    func test_kPa() {
        let kPa = NSNumber(value: 100)
        let pressure = BarometricPressure(kPa: kPa)
        XCTAssertEqual(pressure.kPa, kPa)
    }
    
    func test_inHg() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.inHg.stringValue, NSNumber(value: 29.5301).stringValue)
    }
    
    func test_hPa() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.hPa.stringValue, NSNumber(value: 1000).stringValue)
    }
    
    func test_mBar() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.mBar.stringValue, NSNumber(value: 1000).stringValue)
    }
    
    func test_mmHg() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.mmHg.stringValue, NSNumber(value: 750.06375541921).stringValue)
    }
    
    func test_torr() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.torr.stringValue, NSNumber(value: 750.06375541921).stringValue)
    }
    
    func test_atm() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.atm.stringValue, NSNumber(value: 0.98692326671601).stringValue)
    }
    
    func test_psi() {
        let pressure = BarometricPressure(kPa: NSNumber(value: 100))
        XCTAssertEqual(pressure.psi.stringValue, NSNumber(value: 14.503773773022).stringValue)
    }
}
