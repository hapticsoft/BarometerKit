//
//  BarometerDelegate.swift
//  BarometerKit
//
//  Created by Bruno Godbout on 2018-07-30.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import Foundation

/// The delegate of a Barometer object must adopt the BarometerDelegate protocol.
/// The methods of this protocol keep the delegate informed of the Barometer's activity
/// such as changes in barometric pressure.
public protocol BarometerDelegate {
    
    /// Tells the delegate that the barometric pressure has changed.
    ///
    /// - Parameter to: new barometric pressure value.
    func pressureChanged(to: NSNumber)
}

