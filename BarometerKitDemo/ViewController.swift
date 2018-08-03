//
//  ViewController.swift
//  BarometerKitDemo
//
//  Created by Bruno Godbout on 2018-08-02.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import UIKit
import os
import BarometerKit

class ViewController: UIViewController, BarometerDelegate {
    func pressureChanged(to newValue: BarometricPressure) {
        kPaValueLabel.text  = formatter.string(from: newValue.kPa)
        inHgValueLabel.text = formatter.string(from: newValue.inHg)
    }
    
    var barometer = BarometerFactory().create()
    let formatter = NumberFormatter()

    @IBOutlet weak var kPaValueLabel: UILabel!
    @IBOutlet weak var inHgValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 6
        kPaValueLabel.text = ""
        inHgValueLabel.text = ""
        barometer.delegate = self
        barometer.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        barometer.stop()
    }


}

