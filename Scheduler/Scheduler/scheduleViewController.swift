//
//  scheduleViewController.swift
//  Scheduler
//
//  Created by Avi Arora on 12/10/17.
//  Copyright © 2017 Himanshu Minocha. All rights reserved.
//

import UIKit

class scheduleViewController: UIViewController {
    var defaults = UserDefaults.standard
    var cards:[CardView] = []
    var specialDates:[SpecialDate] = []
    var anchorDates:[AnchorDate] = []
    @IBOutlet var dayLabel:UILabel!
    
    
    var colors:[UIColor] = [UIColor.appleRed(), UIColor.appleBlue(), UIColor.applePink(), UIColor.appleGreen(), UIColor.appleOrange(), UIColor.applePurple(), UIColor.appleYellow()]
    
    
    
    @IBOutlet var nextDayButton:UIButton!
    @IBOutlet var topView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let classes = createPeriodObjects()
        print("from schedule vc")
        print(classes)
        
        // Do any additional setup after loading the view.
        self.topView.layer.backgroundColor = UIColor.white.cgColor
        self.topView.layer.borderColor = UIColor.gray.cgColor
        //        cell.layer.borderWidth = 0.0
        //        cell.layer.cornerRadius = 5
        self.topView.layer.masksToBounds = false
        //        cell.layer.shadowRadius = 1.0
        self.topView.layer.shadowColor = UIColor.lightGray.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)//CGSize(1.0, 1.0)
        self.topView.layer.shadowOpacity = 0.70
        self.topView.layer.shadowRadius = 3.0
        
        var periods:[String] = ["-", "-", "-", "-", "-"]
        var colors:[UIColor] = [UIColor.appleRed(), UIColor.appleBlue(), UIColor.applePink(), UIColor.appleGreen(), UIColor.appleOrange()]
        for i in 0 ..< 5 {
            let frame = CGRect(x: Int(self.view.frame.width), y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
            let card = CardView(frame: frame)
            card.setPeriodName(name: periods[i])
            //            card.setPeriodNumber(perNum: i + 1)
            card.setPeriodNumber(perNum: 0, color: colors[i])
            cards.append(card)
            self.view.addSubview(card)
            
            
            UIView.animate(withDuration: 0.2 * Double(i) + 0.3 , animations: {
                card.frame = CGRect(x: 10 , y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
            }, completion: nil)
            
            
        }
        
        updateDisplayDate(day: 0)
        
//        self.nextDayButton.layer.backgroundColor = UIColor.appleBlue().withAlphaComponent(0.7).cgColor
//        self.nextDayButton.layer.borderColor = UIColor.gray.cgColor
//        //        cell.layer.borderWidth = 0.0
//        //        cell.layer.cornerRadius = 5
//        self.nextDayButton.layer.masksToBounds = false
//        //        cell.layer.shadowRadius = 1.0
//        self.nextDayButton.layer.shadowColor = UIColor.lightGray.cgColor
//        self.nextDayButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)//CGSize(1.0, 1.0)
//        self.nextDayButton.layer.shadowOpacity = 0.70
//        self.nextDayButton.layer.shadowRadius = 3.0
//        self.nextDayButton.layer.cornerRadius = 25.5
//        self.view.bringSubview(toFront: nextDayButton)
//        
        getSpecialDates()
        print(specialDates)
        //print(checkSpecialDate())
        

    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createPeriodObjects() -> [Period] 
    {
        var classes = [Period]()
        
        for i in 0 ..< 7
        {
            
            if defaults.value(forKey: "period" + String(i)) != nil {
                let dataString = defaults.value(forKey: "period" + String(i)) as! String
                let dataArr = dataString.components(separatedBy: "&&")
                let tempPeriod = Period(className: dataArr[0], period: i + 1)
                classes.append(tempPeriod)
                
                
                
                
            }
           
            
            
        }
      
        
        
        
        return classes
        
    }
    func getSpecialDates()
    {
        
        if let path = Bundle.main.path(forResource: "specialDates", ofType: "json") {
            do {
                //print("a")
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let jsonDates = jsonResult["dates"] as? [Dictionary<String, String>]{
                    // do stuff
                    //print(jsonDates)
                    for temp:Dictionary<String, String> in jsonDates
                    {
                        //print(temp)
                        
                        var dateComponents = DateComponents()
                        dateComponents.year = 2018
                        dateComponents.month = Int(temp["month"]!)
                        dateComponents.day = Int(temp["day"]!)
                        let userCalendar = Calendar.current
                        let dateTemp = userCalendar.date(from: dateComponents)
                        
                        specialDates.append(SpecialDate(date: dateTemp!, reason: temp["reason"]!, type: temp["type"]!))
 
                        
                    }
                }
            } catch {
                // handle error
                print("error retrieving dates array from JSON file")
            }
        }
        
        
    }
    func getAnchorDates()
    {
        
        if let path = Bundle.main.path(forResource: "anchors", ofType: "json") {
            do {
                //print("a")
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let jsonDates = jsonResult["anchors"] as? [Dictionary<String, String>]{
                    // do stuff
                    //print(jsonDates)
                    for temp:Dictionary<String, String> in jsonDates
                    {
                        //print(temp)
                        
                        var dateComponents = DateComponents()
                        dateComponents.year = 2018
                        dateComponents.month = Int(temp["month"]!)
                        dateComponents.day = Int(temp["day"]!)
                        let userCalendar = Calendar.current
                        let dateTemp = userCalendar.date(from: dateComponents)
                        
                        anchorDates.append(AnchorDate(date: dateTemp!, day: Int(temp["schedule"]!)!))
                        
                        
                    }
                }
            } catch {
                // handle error
                print("error retrieving dates array from JSON file")
            }
        }
        
        
    }
    func checkSpecialDate(date:Date) -> Bool
    {
        /*var date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = month
        dateComponents.day = day
        let userCalendar = Calendar.current
        date = userCalendar.date(from: dateComponents)!
        
         */
        var isSpecial = false
        
        for temp:SpecialDate in specialDates
        {
            if temp.date == date
            {
                isSpecial = true
                break
            }
            
        }
        return isSpecial
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func createMatrix(classes:[Period]) -> [[Period]] {
        var matrix:[[Period]] = [[],[],[],[],[],[],[]]
        
        for i in 0 ..< matrix.count {
            for j in 0 ..< 5 {
                for k in 0 ..< classes.count {
                    if classes[k].period - 1 == j {
                        matrix[i].append(classes[k])
                    }
                }
            }
            
            
            for k in 0 ..< classes.count {
                classes[k].period = (classes[k].period + 2) % 7
            }
            print("")
            
            
        }
        
        for i in 0 ..< matrix.count {
            for j in 0 ..< matrix[i].count {
                print(matrix[i][j].className + " ")
                
            }
            print()
        }
        
        
        return matrix
    }
    
    
    
    func updateDisplayDate(day:Int) {
        let matrix:[[Period]] = createMatrix(classes: createPeriodObjects())
        
        for i in 0 ..< (matrix[day]).count {
            print("\(matrix[day][i].className)")
            var perNum:Int = 7;
            if matrix[day][i].period == 0 {
                perNum = 7;
            }
            else {
               perNum =  matrix[day][i].period
            }
            cards[i].setPeriodNumber(perNum: perNum, color: colors[matrix[day][i].period]) //.perLabel.setTitle("\(matrix[day][i].period)", for: .normal)
            cards[i].periodName.text = matrix[day][i].className
           
            
        }
    
        
        updateLabel(day:day)
    }
    var day = 0;
    var daysProgressed = 0;
    @IBAction func next() {
         day = (day + 1)  % 7
        daysProgressed += 1
        updateDisplayDate(day:  day )
        
    }
    
    @IBAction func back() {
        if day == 0 {
            day = 6;
        }
        else {
            day = day - 1
        }
        daysProgressed -= 1
        updateDisplayDate(day:  day )
        
    }
    
    
    
    func updateLabel(day: Int) {
        if day == 0 {
            dayLabel.text = "A Day"
        }
        else if day == 1 {
             dayLabel.text = "B Day"
        }
        else if day == 2 {
             dayLabel.text = "C Day"
        }
        else if day == 3 {
             dayLabel.text = "D Day"
        }
        else if day == 4 {
            dayLabel.text = "E Day"
        }
        else if day == 5 {
             dayLabel.text = "F Day"
        }
        else if day == 6 {
             dayLabel.text = "G Day"
        }
        

        
        let today = NSDate() //Use datePicker.date
        let nextDay = NSCalendar.current.date(byAdding: Calendar.Component.day, //Here you can add year, month, hour, etc.
            value: daysProgressed,  //Here you can add number of units
            to: today as Date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"//"MM/dd/yy"
        let dateDisplay = dateFormatter.string(from: nextDay!)
        print(dateDisplay)
        
        dayLabel.text = "\(dayLabel.text!) - \(dateDisplay)"
        
        
    }
    
    
    func validateDate(anchorDate:AnchorDate) -> Int {
        
        
        
       
        var validationProgress:Int = 0
        var itterator:Int = 0
        while (NSCalendar.current.date(byAdding: Calendar.Component.day, value: validationProgress, to: anchorDate.date as Date) != Date()) {
            if Calendar.current.isDateInWeekend(Date()) {
                print("is weekend")
                validationProgress += 1
            }
            else if (checkSpecialDate(date: NSCalendar.current.date(byAdding: Calendar.Component.day, value: validationProgress, to: anchorDate.date as Date)!)) { //This is where there is a check for a special date
                print("is special date ")
                 validationProgress += 1
            }
            else {
                itterator += 1
                validationProgress += 1
            }
        }
        
        
        
        print("\(itterator % 7)")
        print("The DAY IS \(anchorDate.day + itterator % 7)")
        
        return itterator - (itterator / 7)
    }

    
    
}
