//
//  SimulatorBarometer.swift
//  BarometerKitDemo
//
//  Created by Bruno Godbout on 2018-08-03.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation
import os
import BarometerKit

class SimulatorBarometer: Barometer {
    var currentPressure: BarometricPressure?
    
    static private func randomPressure() -> NSNumber {
        return NSNumber(value: arc4random_uniform(100))
    }
    
    var timer : Timer?
    
    func start(onPressureChange pressureChanged: @escaping (BarometricPressure) -> Void) {
        
        // Start background task that calls the delegate at fixed intervals.
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self](t) in
            self?.currentPressure = BarometricPressure(kPa: SimulatorBarometer.randomPressure())
            
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
