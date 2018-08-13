//
//  Barometer.swift
//  BarometerKit
//
//  Created by Bruno Godbout on 2018-07-19.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation

/// Monitor changes to the barometric pressure and notify the delegate of said changes.
public protocol Barometer {    
    /// The most recent reading of the iPhone's barometer sensor.
    var currentPressure: BarometricPressure? { get }
    
    /// Starts monitoring the barometric pressure and call the pressureChanged closure with new pressure values.
    func start(onPressureChange pressureChanged: @escaping (BarometricPressure) -> Void) -> Void
    
    /// Stops monitoring the barometric pressure and stops calling the delegate with new pressure values.
    func stop() -> Void
}
