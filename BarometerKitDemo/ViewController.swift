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

class ViewController: UIViewController {
    
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
        barometer.start() { [weak self] (newValue) in
            self?.kPaValueLabel.text  = self?.formatter.string(from: newValue.kPa)
            self?.inHgValueLabel.text = self?.formatter.string(from: newValue.inHg)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        barometer.stop()
    }


}

