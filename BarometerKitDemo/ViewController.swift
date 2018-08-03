//
//  ViewController.swift
//  BarometerKitDemo
//
//  Created by Bruno Godbout on 2018-08-02.
//  Copyright © 2018 Haptic Software. All rights reserved.
//

import UIKit
import BarometerKit

class ViewController: UIViewController, BarometerDelegate {
    func pressureChanged(to newValue: BarometricPressure) {
        kPaValueLabel.text = newValue.kPa.stringValue
    }
    

    @IBOutlet weak var kPaValueLabel: UILabel!
    @IBOutlet weak var inHgValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kPaValueLabel.text = ""
        inHgValueLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

