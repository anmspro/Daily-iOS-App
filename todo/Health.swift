//
//  Health.swift
//  todo
//
//  Created by CSE on 1/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit


class Health: UIViewController {
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    var bmi = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BMITapped(_ sender: Any) {
        let userAge = age.text
        let userHeight = (height.text! as NSString).floatValue
        let userWeight = (weight.text! as NSString).floatValue
        let result = (userWeight/(userHeight * userHeight))
        let calculatedbmi = NSString(format: "%.2f", result) as String
        bmi = calculatedbmi
        self.performSegue(withIdentifier: "BMIController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var sendBMI =
        segue.destination as! BMIController
        sendBMI.result = self.bmi
    }
    


}
