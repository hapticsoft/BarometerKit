//
//  BarometricPressure.swift
//  BarometerKit
//
//  Created by Bruno Godbout on 2018-08-02.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation

/// Encapsulates barometric pressure values and provide conversion between units of measurements.
/// - SeeAlso: [weather.gov](https://www.weather.gov/media/epz/wxcalc/pressureConversion.pdf "Pressure conversion formulas")
/// - SeeAlso: [unit juggler](https://www.unitjuggler.com/pressure-conversion.html "Pressure conversion")
public struct BarometricPressure {
    
    /// Pressure measured in kilopascals
    public let kPa: NSNumber
    
    /// Initializes and returns a `BarometricPressure` value with the specified kilopascal value.
    public init(kPa: NSNumber) {
        self.kPa = kPa
    }
    
    /// Pressure measured in inches of mercury
    public var inHg: NSNumber {
        return NSNumber(value: kPa.doubleValue * 0.295301)
    }
    
    /// Pressure measured in hectopascals
    public var hPa: NSNumber {
        return NSNumber(value: kPa.doubleValue * 10)
    }
    
    /// Pressure measured in millibars
    public var mBar: NSNumber {
        return hPa
    }
    
    /// Pressure measured in millimeters of mercury
    public var mmHg: NSNumber {
        return NSNumber(value: kPa.doubleValue * 7.5006375541921)
    }
    
    /// Pressure measured in torrs
    public var torr: NSNumber {
        return mmHg
    }
    
    /// Pressure measured in standard atmospheres
    public var atm: NSNumber {
        return NSNumber(value: kPa.doubleValue * 0.0098692326671601)
    }
    
    /// Pressure measured in pounds per square inch
    public var psi: NSNumber {
        return NSNumber(value: kPa.doubleValue * 0.14503773773022)
    }
}
