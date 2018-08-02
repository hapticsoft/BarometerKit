//
//  BarometricPressure.swift
//  BarometerKit
//
//  Created by Bruno Godbout on 2018-08-02.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation

public struct BarometricPressure {
    public let kPa: NSNumber
    
    public init(kPa: NSNumber) {
        self.kPa = kPa
    }
    
    public var inHg: NSNumber {
        return NSNumber(value: kPa.floatValue * 0.295300)
    }
}
