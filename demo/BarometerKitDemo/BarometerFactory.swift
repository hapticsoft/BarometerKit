//
//  BarometerFactory.swift
//  BarometerKitDemo
//
//  Created by Bruno Godbout on 2018-08-03.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation
import os
import BarometerKit

class BarometerFactory {
    func create() -> Barometer {
        var barometer: Barometer
        
        #if targetEnvironment(simulator)
        
        // There is no support for the iPhone Altimeter in the simulators, so we use our own.
        os_log("Using Simulated barometer", log: .default, type: .debug)
        barometer = SimulatorBarometer()
        
        #else
        
        os_log("Using iPhone barometer", log: .default, type: .debug)
        barometer = PhoneBarometer()
        
        #endif
        
        return barometer
    }
}
