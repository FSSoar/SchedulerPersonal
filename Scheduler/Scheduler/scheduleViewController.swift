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
    var transitionButtons:[UIButton] = []
    @IBOutlet var dayLabel:UILabel!
    
    
    var colors:[UIColor] = [UIColor.appleRed(), UIColor.appleBlue(), UIColor.applePink(), UIColor.appleGreen(), UIColor.appleOrange(), UIColor.applePurple(), UIColor.appleYellow()]
    
    
    
    @IBOutlet var prevDayButton:UIButton!
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
        var times:[String] = ["7:30 - 8:30", "8:35 - 9:35", "9:40 - 10:40", "10:45 - 12:40", "12:45 - 1:50"]
        for i in 0 ..< 5 {
            let frame = CGRect(x: Int(self.view.frame.width), y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
            let card = CardView(frame: frame)
            card.setPeriodName(name: periods[i])
            //            card.setPeriodNumber(perNum: i + 1)
            card.setPeriodNumber(perNum: 0, color: colors[i])
            card.timeLabel.text = times[i]
            card.actionButton.addTarget(self, action: #selector(normalView), for: .touchUpInside)
            card.actionButton.isHidden = true
            card.addButton.tag = i
            card.addButton.addTarget(self, action: #selector(showGetAssignment(sender:)), for: .touchUpInside)
            cards.append(card)
            
            
            
            let button = UIButton()
            button.tag = i
            button.frame = frame
            //            button.addTarget(self, action: #selector(conductTransition(sender:button)), for: .touchUpInside)
            button.addTarget(self, action: #selector(conductTransition), for: .touchUpInside)
            transitionButtons.append(button)
            
            self.view.addSubview(card)
            self.view.addSubview(button)
            
            
            
            
            
            
            UIView.animate(withDuration: 0.2 * Double(i) + 0.3 , animations: {
                card.frame = CGRect(x: 10 , y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
                self.transitionButtons[i].frame = CGRect(x: 10 , y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
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
        getAnchorDates()
        print(specialDates)
        print(anchorDates)
        validateDate(anchorDate: anchorDates[0], currDate: Date())
        highlightCurrentPeriod()
        
        //print(checkSpecialDate())
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //showGetAssignment(period: 1)
        
    }
    
    
    @objc func conductTransition(sender:UIButton) {
        print("\(sender.tag)")
        
        
        
        
        
        
        UIView.animate(withDuration: 0.5 , animations: {
            
            for i in 0 ..< 5 {
                self.cards[i].actionButton.isHidden = false
                self.transitionButtons[i].isHidden = true
                if i > sender.tag {
                    self.cards[i].frame = CGRect(x: 10 , y: Int(95 + self.cards[i].frame.origin.y + self.view.frame.height), width: (Int)(self.view.frame.width - 20), height: 125)
                }
                if i < sender.tag {
                    self.cards[i].frame = CGRect(x: 10 , y: Int( (self.cards[0].frame.origin.y - self.cards[sender.tag].frame.origin.y) - self.cards[i].frame.origin.y ), width: (Int)(self.view.frame.width - 20), height: 125)
                }
            }
            self.cards[sender.tag].frame = CGRect(x: 10 , y: 95, width: (Int)(self.view.frame.width - 20), height: Int(self.view.frame.height - 105))
            
            let arr = self.getAssignments(period: Int(self.cards[sender.tag].perLabel.currentTitle!)! )
            self.cards[sender.tag].initExpandedView(events: arr)
            
            
        }, completion: nil)
        
        
        
        
    }
    
    
    
    @objc func normalView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            for i in 0 ..< 5 {
                self.cards[i].actionButton.isHidden = true
                self.transitionButtons[i].isHidden = false
                self.cards[i].frame = CGRect(x: 10 , y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
                self.transitionButtons[i].frame = CGRect(x: 10 , y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
//                showGetAssignment()
                self.cards[i].closeExpandedView()
            }
        }, completion: nil)
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
                
                
//                if let url = URL(string: "https://sites.google.com/site/falconstepstest/about-us/specialDates.json?attredirects=0&d=1") {
//                    do {
//                        let contents = try String(contentsOf: url)
//                        print(contents)
//                    } catch {
//                        // contents could not be loaded
//                    }
//                } else {
//                    // the URL was bad!
//                }
                
                let data = try Data(contentsOf: URL(string: "https://drive.google.com/file/d/1viN-R2EHXgjnbIj2JCrQc1h2HJHmnoTi/view?usp=sharing")! , options: .mappedIfSafe)  //Where it says URL can we actually insert a webURL??
                print("data \(data)")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                print(jsonResult)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let jsonDates = jsonResult["dates"] as? [Dictionary<String, String>]{
                    // do stuff
                    //print(jsonDates)
                    
                    print(" result \(jsonResult)")
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
                        print(specialDates.count)
                        
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
    func checkSpecialDateReturn(date:Date) -> SpecialDate
    {
        //returns the special day associated with a give date
        //ONLY CALLED WHEN YOU KNOW A DAY IS SPECIAL!
        var isSpecial = false
        var foundSpecial = SpecialDate(date: date, reason: "", type: "")
        for temp:SpecialDate in specialDates
        {
            if temp.date == date
            {
                isSpecial = true
                foundSpecial = temp
                break
            }
            
        }
        return foundSpecial
        
    }
    func checkSpecialDateTime(date:Date) -> [String]
    {
    
        var isSpecial = false
        var foundSpecial = SpecialDate(date: date, reason: "", type: "")
        for temp:SpecialDate in specialDates
        {
            if temp.date == date
            {
                isSpecial = true
                foundSpecial = temp
                return foundSpecial.returnTimeArray(keyCode: foundSpecial.type)
            }
            
        }
        return ["7:30 - 8:30", "8:35 - 9:35", "9:40 - 10:40", "10:45 - 12:40", "12:45 - 1:50"]
        
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
        for i in 0 ..< cards.count {
            cards[i].changeToWhite()
        }
        daysProgressed += 1
        let today = Date()
        let incr = NSCalendar.current.date(byAdding: Calendar.Component.day, value: daysProgressed, to: today as Date)
        validateDate(anchorDate: anchorDates[0], currDate: incr!)
        if (daysProgressed == 0)
        {
                highlightCurrentPeriod()
        }
        
    }
    
    @IBAction func back() {
        for i in 0 ..< cards.count {
            cards[i].changeToWhite()
        }
        daysProgressed -= 1
        
        let today = Date()
        let incr = NSCalendar.current.date(byAdding: Calendar.Component.day, value: daysProgressed, to: today as Date)
        validateDate(anchorDate: anchorDates[0], currDate: incr!)
        if (daysProgressed == 0)
        {
            highlightCurrentPeriod()
        }
        
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
    
    
    func validateDate(anchorDate:AnchorDate, currDate:Date) -> Int {

        
        var validationProgress:Int = 0
        var itterator:Int = 0
        
        //        var currDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currDate)
        let month = calendar.component(.month, from: currDate)
        
        let day2  = calendar.component(.day, from: anchorDate.date)
        let month2 = calendar.component(.month, from: anchorDate.date)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = month
        dateComponents.day = day
        let userCalendar = Calendar.current
        let dateForComp = userCalendar.date(from: dateComponents)!
        
        
        var dateComponents2 = DateComponents()
        dateComponents2.year = 2018
        dateComponents2.month = month2
        dateComponents2.day = day2
        //        let userCalendar = Calendar.current
        let dateForComp2 = userCalendar.date(from: dateComponents2)!
        
        if dateForComp2 == dateForComp {
            prevDayButton.isEnabled = false
        }
        else {
            prevDayButton.isEnabled = true
        }
        
        
        if (Calendar.current.isDateInWeekend(dateForComp)) {
            print("is weekend")
            validationProgress += 1
            
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
            let dayInWeek = dateFormatter.string(from: dateForComp)
            dayLabel.text = "\(dayInWeek)"
            
            
            for i in 0 ..< cards.count {
                cards[i].isHidden = true
            }
            
        }
        else if checkSpecialDate(date: dateForComp)  {
            print("got here 1")
            let currentSpecial = checkSpecialDateReturn(date: dateForComp)
            if(currentSpecial.type == "N")
            {
                dayLabel.text = "No School"
                for i in 0 ..< cards.count {
                    cards[i].isHidden = true
                }
            }
            else if(currentSpecial.type == "E")
            {
                print("got here early release")
                let times = checkSpecialDateTime(date: currentSpecial.date)
                for i in 0 ..< cards.count {
                    cards[i].isHidden = false
                    cards[i].timeLabel.text = times[i]
                }
            }
            else if(currentSpecial.type == "AD")
            {
                print("got here early dismissal")
                let times = checkSpecialDateTime(date: currentSpecial.date)
                for i in 0 ..< cards.count {
                    cards[i].isHidden = false
                    cards[i].timeLabel.text = times[i]
                }
            }
            
        }
        else {
            
            for i in 0 ..< cards.count {
                let times = ["7:30 - 8:30", "8:35 - 9:35", "9:40 - 10:40", "10:45 - 12:40", "12:45 - 1:50"]
                cards[i].isHidden = false
                cards[i].timeLabel.text = times[i]
            }
            
            
            
            while (NSCalendar.current.date(byAdding: Calendar.Component.day, value: validationProgress, to: anchorDate.date as Date) != dateForComp) {
                let tempDate = NSCalendar.current.date(byAdding: Calendar.Component.day, value: validationProgress, to: anchorDate.date as Date)
                if Calendar.current.isDateInWeekend(tempDate!) {
                    print("is weekend")
                    validationProgress += 1
                    //                dayLabel.text = "Its the weekend"
                    
                }
                else if (checkSpecialDate(date: NSCalendar.current.date(byAdding: Calendar.Component.day, value: validationProgress, to: anchorDate.date as Date)!)) { //This is where there is a check for a special date
                    print("is special date 1")
                    validationProgress += 1
                    //                dayLabel.text = "Special Date"
                }
                else {
                    itterator += 1
                    validationProgress += 1
                    
                }
            }
            
            
            
            print("\(itterator % 7)")
            self.day = anchorDate.day + itterator % 7
            print("The DAY IS \(anchorDate.day + itterator % 7)")
            updateDisplayDate(day:  anchorDate.day + itterator % 7)
            
        }
        return itterator - (itterator / 7)
    }
    func highlightCurrentPeriod()
    {
        for i in 0 ..< cards.count {
            cards[i].changeToWhite()
        }
        var currDate = Date()
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: currDate)
        dateComponents.minute = calendar.component(.minute, from: currDate)
        currDate = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 7
        dateComponents.minute = 30
        
        let p1I = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 8
        dateComponents.minute = 35
        
        let p2I = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 9
        dateComponents.minute = 40
        
        let p3I = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 10
        dateComponents.minute = 45
        
        let p4I = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 12
        dateComponents.minute = 45
        
        let p5I = calendar.date(from: dateComponents)!
        
        dateComponents.hour = 1
        dateComponents.minute = 50
        
        let p5E = calendar.date(from: dateComponents)!
        
        if(currDate >= p1I) && (currDate <= p2I)
        {
            cards[0].changeToGray()
        }
        else if (currDate >= p2I) && (currDate <= p3I)
        {
            cards[1].changeToGray()
        }
        else if (currDate >= p3I) && (currDate <= p4I)
        {
            cards[2].changeToGray()
        }
        else if (currDate >= p4I) && (currDate <= p5I)
        {
            cards[3].changeToGray()
        }
        else if (currDate >= p5I) //&& (currDate <= p5E)
        {
            cards[4].changeToGray()
        }
        
        
        
        
    }
    @objc func showGetAssignment(sender:UIButton) {
        let periodButton = sender.tag
        let periodStr = cards[sender.tag].perLabel.currentTitle
        print("Period String \(periodStr)")
        let period = Int(periodStr!)
        let alertController = UIAlertController(title: "New Assignment", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            alert -> Void in
            let assignmentField = alertController.textFields![0] as UITextField
            
            
            if assignmentField.text != ""{
                print(assignmentField.text!)
                //Save user data
                
                self.saveAssignment(period: period!, assignment: assignmentField.text!, indexOfCard: sender.tag)
                
                
                
                
                
            }
            
            else {
                let errorAlert = UIAlertController(title: "Error", message: "Please input an assignment", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Homework"
            textField.textAlignment = .center
        })
        
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    func saveAssignment(period:Int, assignment:String, indexOfCard:Int)
    {
        if var arr:[String] = defaults.value(forKey: "period" + String(period) + "Assignments") as? [String]
        {
            arr.append(assignment)
            defaults.set(arr, forKey: "period" + String(period) + "Assignments")
            cards[indexOfCard].initExpandedView(events: arr)
            
            
        }
        else
        {
            var arr = [String]()
            arr.append(assignment)
            defaults.set(arr, forKey: "period" + String(period) + "Assignments")
            cards[period].initExpandedView(events: arr)
            
        }
        
        
        
        
    }
    func getAssignments(period:Int) -> [String]
    {
        if var arr:[String] = defaults.value(forKey: "period" + String(period) + "Assignments") as? [String]
        {
            return arr
            
        }
        
        return [""]
        
    }
    func removeAssignment(period:Int, assignment:String)
    {
        if var arr:[String] = defaults.value(forKey: "period" + String(period) + "Assignments") as? [String]
        {
            for i in 0 ..< arr.count {
                if assignment == arr[i]
                {
                    arr.remove(at: i)
                    break
                }
            }
          
            defaults.set(arr, forKey: "period" + String(period) + "Assignments")
            
        }
        
    }

    

    
    
}
