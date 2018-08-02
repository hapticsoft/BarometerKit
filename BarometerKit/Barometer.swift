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
    /// The delegate that will be called with the barometric pressure data.
    var delegate: BarometerDelegate? { get set }
    
    /// The most recent reading of the iPhone's barometer sensor.
    var currentPressure: BarometricPressure? { get }
    
    /// Starts monitoring the barometric pressure and calling the delegate with new pressure values.
    func start() -> Void
    
    /// Stops monitoring the barometric pressure and stops calling the delegate with new pressure values.
    func stop() -> Void
}
