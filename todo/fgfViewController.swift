//
//  fgfViewController.swift
//  todo
//
//  Created by CSE on 4/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

/*
calendarVars.swift:

//
//  CalendarVars.swift
//  TodoCalender
//
//  Created by kuet on 23/10/19.
//  Copyright © 2019 kuet. All rights reserved.
//

import Foundation

var date = Date()
var calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)

view:
//
//  ViewController.swift
//  TodoCalender
//
//  Created by kuet on 23/10/19.
//  Copyright © 2019 kuet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var Calender: UICollectionView!
    
    //var uid: String = ""
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let DaysOfMonth = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var NumberOfEmptyBox = Int() //The number of empty box at the start of the current month
    
    var NextNumberOfEmptyBox = Int() //the same for next month
    
    var PreviouNumberOfEmptyBox = Int() //the same for prev month
    
    var Direction = 0 // =0 if we are at the current month, =1 if we are in a future month, =-1 if we are in a past month
    
    var PositionIndex = 0 //here we will store the above vars of the empty boxes
    
    var currentDay = ""
    
    var LeapYearCounter = 3 // its 3 because the next time february has 29 days is in 1 years
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
    }
    
    
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            Direction = 1
            
            if LeapYearCounter < 5 {
                LeapYearCounter += 1
            }
            
            if LeapYearCounter == 4{
                DaysInMonths[1] = 29
            }
            
            if LeapYearCounter == 5{
                LeapYearCounter = 1
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calender.reloadData()
        default:
            Direction = 1
            GetStartDateDayPosition()
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calender.reloadData()
        }
    }
    
    @IBAction func Prev(_ sender: Any) {
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            Direction = -1
            
            if LeapYearCounter > 0 {
                LeapYearCounter -= 1
            }
            
            if LeapYearCounter == 0{
                DaysInMonths[1] = 29
                LeapYearCounter = 4
            }else{
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calender.reloadData()
        default:
            month -= 1
            Direction = -1
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calender.reloadData()
        }
    }
    
    func GetStartDateDayPosition() //this function give us the number of emnpty box
    {
        switch Direction {
        case 0:                     //if we r at current month
            switch day{
            case 1...7:
                NumberOfEmptyBox = weekday - day
            case 8...14:
                NumberOfEmptyBox = weekday - day - 7
            case 15...21:
                NumberOfEmptyBox = weekday - day - 14
            case 22...28:
                NumberOfEmptyBox = weekday - day - 21
            case 29...31:
                NumberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            
        case 1...:                  //if we are at a future month
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            if NextNumberOfEmptyBox >= 7{
                NextNumberOfEmptyBox -= 7
            }
            PositionIndex = NextNumberOfEmptyBox
           
            
        case -1:                  //if we are at a past month
            PreviouNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex)%7)
            
            if PreviouNumberOfEmptyBox == 7{
                PreviouNumberOfEmptyBox = 0
            }
            if PreviouNumberOfEmptyBox > 7{
                PreviouNumberOfEmptyBox -= 7
            }
            PositionIndex = PreviouNumberOfEmptyBox
            
        default:
            fatalError()
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {      //it returns the number of days in the month + the number of empty boxes based on direction
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviouNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.Datebtn.tag = indexPath.row
        cell.Datebtn.addTarget(self,action: #selector(DatebtnTapped(sender: )),for:.touchUpInside)
        
        cell.backgroundColor = UIColor.white
       
        cell.Datebtn.setTitleColor(UIColor.black, for: .normal)
        if cell.isHidden{
            cell.isHidden = false
        }
        
        cell.Datebtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        
        switch Direction {      //it returns the number of days in the month + the number of empty boxes based on direction
        case 0:
            cell.Datebtn.setTitle("\(indexPath.row + 1  - NumberOfEmptyBox)", for: .normal)
        case 1...:
            cell.Datebtn.setTitle("\(indexPath.row + 1 - NextNumberOfEmptyBox)", for: .normal)
        case -1:
            cell.Datebtn.setTitle("\(indexPath.row + 1 - PreviouNumberOfEmptyBox)", for: .normal)
        default:
            fatalError()
        }
        
        if Int(cell.Datebtn.currentTitle!)! < 1 {
            //hides cell less than 1
            cell.isHidden = true
        }
        
        //show weekend days in red
        
        switch indexPath.row{
        case 5,6,12,13,19,20,26,27,33,34:       //weekend day cells
            if Int(cell.Datebtn.currentTitle!)! > 0{
                cell.Datebtn.setTitleColor(UIColor.red, for: .normal)
            }
        default:
            break
        }
        
        
        //current day color blue
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1  == day{
            cell.backgroundColor = UIColor.blue
            cell.Datebtn.setTitleColor(UIColor.white, for: .normal)
            cell.Datebtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        }
        
        return cell
    }
    
    @IBAction func DatebtnTapped(sender : UIButton) {
        let daydata =  sender.currentTitle!
        let mdata =  currentMonth
        let ydata =  year
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToDoListViewController") as! ToDoListViewController
        vc.day = daydata
        vc.month = mdata
        vc.year = ydata
        //vc.userID = uid
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

datecollectionviewcell:
//
//  DateCollectionViewCell.swift
//  TodoCalender
//
//  Created by kuet on 23/10/19.
//  Copyright © 2019 kuet. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Datebtn: UIButton!
}


import UIKit

class fgfViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
*/
