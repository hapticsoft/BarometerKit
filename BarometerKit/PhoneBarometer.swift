//
//  PhoneBarometer.swift
//  BarometerKit
//
//  Created by Bruno Godbout on 2018-06-25.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation
import CoreMotion
import os

/// Monitors the barometric pressure using the iPhone's barometer sensor via
/// Core Motion's CMAltimeter class.
public class PhoneBarometer : Barometer {
    
    // The altimeter used to monitor the barometric pressure changes.
    private var altimeter: CMAltimeter
    
    public var delegate: BarometerDelegate?
    
    public var currentPressure: BarometricPressure?
    
    // For a type that is defined as public, the default initializer is considered internal.
    // If you want a public type to be initializable with a no-argument initializer when used in another module,
    // you must explicitly provide a public no-argument initializer yourself as part of the type’s definition.
    // - SeeAlso: [Swift Access Control - Initializers](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html#ID19 "Initializers") 
    public init() {
        self.altimeter = CMAltimeter()
        self.delegate = nil
        self.currentPressure = nil
    }
    
    public func start() -> Void {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            os_log("Altimeter is not supported on this device.", log: OSLog.default, type: .info)
            return
        }
        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] (altitudeData: CMAltitudeData?, error: Error?) in
            guard error == nil else {
                os_log("An error occured when calling CMAltimeter.startRelativeAltitudeUpdates(): %s", log: OSLog.default, type: .error, (error?.localizedDescription)!)
                return
            }
            guard let data = altitudeData else {
                os_log("altitudeData is nil", log: OSLog.default, type: .error)
                return
            }
            let pressureValue = data.pressure
            os_log("Pressure: %f kPa", log: OSLog.default, type: .debug,  pressureValue.floatValue)
            
            self?.currentPressure = BarometricPressure(kPa: pressureValue)
            self?.delegate?.pressureChanged(to: pressureValue)
        }
    }
    
    public func stop() -> Void {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            os_log("Altimeter is not supported on this device.")
            return
        }
        altimeter.stopRelativeAltitudeUpdates()
    }
}
