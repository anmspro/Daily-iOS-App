//
//  BMIViewController.swift
//  todo
//
//  Created by kuet on 2/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit

class BMIViewController: UIViewController {
    
    @IBOutlet weak var resultBMI: UILabel!
    
    var newresult: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        resultBMI.text = newresult
    }

}



