//
//  BMIController.swift
//  todo
//
//  Created by kuet on 3/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit

class BMIController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var BMIStateLabel: UILabel!
    
    @IBOutlet weak var imageLoad: UIImageView!
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let res = (result as NSString).floatValue
        if res < 18.5
        {
            let final = (String) (res)
            bmiLabel.text = final
            BMIStateLabel.text = "You are underweight!"
            let imageURL = URL(string: "https://assets.lybrate.com/q_auto:eco,f_auto,w_850/imgs/product/kwds/diet-chart/Underweight-Diet-Chart.jpg")
            let task = URLSession.shared.dataTask(with: imageURL!)
            
            {(data,response,Error) in
                if Error == nil
                {
                    let loadImage = UIImage(data: data!)
                    self.imageLoad.image = loadImage
                }
            }
            task.resume();
        }
        else if res > 18.5 && res < 25
        {
            let final = (String) (res)
            bmiLabel.text = final
            BMIStateLabel.text = "You have a normal weight!"
            imageLoad.image = UIImage(named: "normal")
        }
        else if res > 25 && res < 30
        {
            let final = (String) (res)
            bmiLabel.text = final
            BMIStateLabel.text = "You are overweight!"
            imageLoad.image = UIImage(named: "overweight")
        }
        else if res > 30 && res < 40
        {
            let final = (String) (res)
            bmiLabel.text = final
            BMIStateLabel.text = "You are obese!"
            let imageURL = URL(string: "https://assets.lybrate.com/q_auto:eco,f_auto,w_850/imgs/product/kwds/diet-chart/Obesity-Diet-Chart.jpg")
            let task = URLSession.shared.dataTask(with: imageURL!)
            
            { (data,response,Error) in
                if Error == nil
                {
                    let loadImage = UIImage(data: data!)
                    self.imageLoad.image = loadImage
                }
            }
            task.resume();
        }
        else
        {
            let final = (String) (res)
            bmiLabel.text = final
            BMIStateLabel.text = "You are extremely obese!"
            let imageURL = URL(string: "https://assets.lybrate.com/q_auto:eco,f_auto,w_850/imgs/product/kwds/diet-chart/Fatty-Liver-Diet-Chart.jpg")
            let task = URLSession.shared.dataTask(with: imageURL!)
            
            { (data,response,Error) in
                if Error == nil
                {
                    let loadImage = UIImage(data: data!)
                    self.imageLoad.image = loadImage
                }
            }
            task.resume();
        }
    }



}
