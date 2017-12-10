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
    

    
    @IBOutlet var subjectPicker:UIPickerView!
    
    @IBOutlet var subjectLine:UILabel!
    
    @IBOutlet var subjectField:UITextField!
    
    @IBOutlet var backButton:UIButton!
    @IBOutlet var nextButton:UIButton!
    var subjects = ["Math", "History", "English", "Foreign Language", "Science", "Other Elective"]
    
    var periodCounter = 1;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectPicker.dataSource = self;
        self.subjectPicker.delegate = self;
        backButton.isEnabled = false
         self.subjectPicker.frame = CGRect(x: 0, y: self.view.frame.height + self.subjectPicker.frame.height + 20, width: self.subjectPicker.frame.width, height: self.subjectPicker.frame.height)
        
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
    
    
    
    
    @IBAction func next() {
        periodCounter += 1
        subjectLine.text = "Enter Information For Period \(periodCounter)"
        if periodCounter == 7 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        backButton.isEnabled = true
    }
    
    @IBAction func back() {
        
        periodCounter -= 1
        subjectLine.text = "Enter Information For Period \(periodCounter)"
        
        if periodCounter == 1 {
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
    
}


