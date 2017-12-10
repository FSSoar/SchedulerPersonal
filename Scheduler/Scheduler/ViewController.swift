//
//  ViewController.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 10/23/17.
//  Copyright © 2017 Himanshu Minocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    

    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var subjectPicker:UIPickerView!
    
    @IBOutlet var subjectLine:UILabel!
    
    @IBOutlet var subjectField:UITextField!
    
    @IBOutlet var classNameField: UITextField!
    
    @IBOutlet var backButton:UIButton!
    @IBOutlet var nextButton:UIButton!
    var subjects = ["Math", "History", "English", "Foreign Language", "Science", "Other Elective"]
    
    var periodCounter = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectPicker.dataSource = self;
        self.subjectPicker.delegate = self;
        backButton.isEnabled = false
         self.subjectPicker.frame = CGRect(x: 0, y: self.view.frame.height + self.subjectPicker.frame.height + 20, width: self.subjectPicker.frame.width, height: self.subjectPicker.frame.height)
        progressBar.progress = 0
        
        // Do any additional setup after loading the view, typically from a nib.
        var classes:[Period] = [ Period(className: "gov", period: 1),
                             Period(className: "calc", period: 2),
                             Period(className: "physics", period: 3),
                             Period(className: "lit", period: 4),
                             Period(className: "psych", period: 5),
                             Period(className: "econ", period: 6),
                             Period(className: "7th", period: 7),
                             
                             ]
        
        
       let matrix =  createMatrix(classes: classes)
        
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return subjects[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        subjectField.text = subjects[row]
        

    }
    
    var tempDataArray = [[String]]()
    
    
    @IBAction func next() {
        //if the user is rewriting information that was already previously saved
        let indexIsOccupied = tempDataArray.indices.contains(periodCounter)
        
        if indexIsOccupied
        {
            if (classNameField.text != "") && (subjectField.text != "") //if all necessary information has been entered
            {
                //overwrite the previously stored data
                tempDataArray[periodCounter][0] = classNameField.text!
                tempDataArray[periodCounter][1] = subjectField.text!
                
                
            }
            else
            {
                createAlert(title: "Error in Form", message: "Please fill in both the classname and subject before advancing. You can go back to change it later.")
            }
            //now we must check if the next index has to be populated as well
            let nextIndexIsOccupied = tempDataArray.indices.contains(periodCounter + 1)
            print(nextIndexIsOccupied)
            if nextIndexIsOccupied
            {
                //populate the next page with the appropriate data
                classNameField.text! = tempDataArray[periodCounter + 1][0]
                subjectField.text! = tempDataArray[periodCounter + 1][1]
            }
            else
            {
                //clear the form
                classNameField.text = nil
                subjectField.text = nil
            }
            periodCounter += 1
            subjectLine.text = "Enter Information For Period \(periodCounter + 1)"
            progressBar.progress += 0.143
        
        }
        else
        {
            //if this is the first time the user has visited this page of the form:
            //first we must save the data from the form before giving the impression of advancing to a next page
            if (classNameField.text != "") && (subjectField.text != "") //if all necessary information has been entered
            {
                //save the data
                var row = [String]()
                row.append(classNameField.text!)
                row.append(subjectField.text!)
                tempDataArray.append(row)
                //empty the form
                classNameField.text = nil
                subjectField.text = nil
                periodCounter += 1
                subjectLine.text = "Enter Information For Period \(periodCounter + 1)"
                progressBar.progress += 0.143
                
            }
            else
            {
                createAlert(title: "Error in Form", message: "Please fill in both the classname and subject before advancing. You can go back to change it later.")
                
            }
        }
        
        /*periodCounter += 1
        subjectLine.text = "Enter Information For Period \(periodCounter + 1)"
        progressBar.progress += 0.143*/
        if periodCounter == 6 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        backButton.isEnabled = true
        print(tempDataArray)
    }
    
    @IBAction func back() {
        
        periodCounter -= 1
        subjectLine.text = "Enter Information For Period \(periodCounter + 1)"
        progressBar.progress -= 0.143
        
        classNameField.text! = tempDataArray[periodCounter][0]
        subjectField.text! = tempDataArray[periodCounter][1]
        
        if periodCounter == 0 {
            backButton.isEnabled = false
        }
     nextButton.isEnabled = true
    }
    
    @IBAction func showPicker() {
        
        UIView.animate(withDuration: 1, animations: {
            self.subjectPicker.frame = CGRect(x: 0, y: self.view.frame.height - self.subjectPicker.frame.height - 20, width: self.subjectPicker.frame.width, height: self.subjectPicker.frame.height)
        }, completion: nil)
        
    }

    
    @IBAction func hide() {
        
        UIView.animate(withDuration: 1, animations: {
            self.subjectPicker.frame = CGRect(x: 0, y: self.view.frame.height + self.subjectPicker.frame.height + 20, width: self.subjectPicker.frame.width, height: self.subjectPicker.frame.height)
            
        }, completion: nil)
        self.resignFirstResponder()
       
        
    }
    
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createPeriodObjects(tempDataArray:[[String]]) -> [Period]
    {
        var classes = [Period]()
        
        for i in 0 ..< tempDataArray.count
        {
            let tempPeriod = Period(className: tempDataArray[i][0], period: i + 1)
            classes.append(tempPeriod)
        }
        
        return classes
        
    }
}


