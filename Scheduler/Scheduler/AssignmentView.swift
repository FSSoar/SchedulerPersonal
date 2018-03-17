//
//  AssignmentView.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 1/29/18.
//  Copyright © 2018 Himanshu Minocha. All rights reserved.
//

import UIKit

class AssignmentView: UIView {

    
    
    var defaults = UserDefaults.standard
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    var checkButton:UIButton!
    var assignmentLabel:UILabel!
    var isChecked:Bool = false
    var period:Int = -1
    override func awakeFromNib() {
        
        
//        self.backgroundColor = UIColor.green
        
        
        
        

   
        
        
        
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.gray.cgColor
        //        cell.layer.borderWidth = 0.0
        //        cell.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        //        cell.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)//CGSize(1.0, 1.0)
        self.layer.shadowOpacity = 0.70
        self.layer.shadowRadius = 3.0
        
        checkButton = UIButton()
        checkButton.frame = CGRect(x: 25, y: 5, width: 25, height: 25)
        checkButton.center.y = self.frame.height / 2
//        perLabel1.center.y
//        checkButton.setTitle("1", for: .normal)
        checkButton.layer.cornerRadius = 12.5
        checkButton.layer.borderColor = UIColor.lightBlue().cgColor
        checkButton.layer.borderWidth = 3
        checkButton.layer.backgroundColor = UIColor.white.cgColor
//        checkButton.backgroundColor = UIColor.red.cgColor
//        checkButton.layer.cornerRadius = 22.5
        checkButton.titleLabel!.font = checkButton.titleLabel!.font.withSize(28)// = UIFont(name: "SF-UI-Display-bold", size: 40)
        //        perLabel.center.y = 50
        //        self.addSubview()
        
        checkButton.addTarget(self, action: #selector(checked), for: .touchUpInside)
        
        self.addSubview(checkButton)
        
        assignmentLabel = UILabel()
        assignmentLabel.frame = CGRect(x: self.checkButton.frame.origin.x + 45 +  10, y: 10, width: self.frame.width - 30, height: 40)
        assignmentLabel.text = "THIS IS TEXT"
        assignmentLabel.center.y = self.frame.height / 2
        self.addSubview(assignmentLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checked() {
        if isChecked  {
            isChecked = false
            checkButton.backgroundColor = UIColor.white
            assignmentLabel.textColor = UIColor.black
            assignmentLabel.attributedText =  NSAttributedString(string:  assignmentLabel.text! , attributes: nil)
            saveAssignment(period: self.period, assignment: self.assignmentLabel.text!)
        }
        else {
            isChecked = true
            checkButton.backgroundColor = UIColor.lightBlue()
            assignmentLabel.textColor = UIColor.lightGray
            assignmentLabel.attributedText =  NSAttributedString(string:  assignmentLabel.text! , attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
            removeAssignment(period: self.period, assignment: assignmentLabel.text!)
        }
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

    
    
    
    func saveAssignment(period:Int, assignment:String)
    {
        if var arr:[String] = defaults.value(forKey: "period" + String(period) + "Assignments") as? [String]
        {
            arr.append(assignment)
            defaults.set(arr, forKey: "period" + String(period) + "Assignments")
//            cards[indexOfCard].initExpandedView(events: arr)
            
            
        }
        else
        {
            var arr = [String]()
            arr.append(assignment)
            defaults.set(arr, forKey: "period" + String(period) + "Assignments")
//            cards[period].initExpandedView(events: arr)
            
        }
        
        
        
        
    }

    
    
    
    
    
    

}
