//
//  CardView.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 1/13/18.
//  Copyright © 2018 Himanshu Minocha. All rights reserved.
//

import UIKit

class CardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var perLabel:UIButton!
    var periodName:UILabel!
    var timeLabel:UILabel!
    
    var actionButton:UIButton!
    var addButton:UIButton!
    
    
    var scroll:UIScrollView!
    override func awakeFromNib() {
        self.backgroundColor = UIColor.black
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
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
        
        
        perLabel = UIButton()
        perLabel.frame = CGRect(x: 10, y: 10, width: 45, height: 45)
        perLabel.setTitle("1", for: .normal)
        perLabel.backgroundColor = UIColor.red
        perLabel.layer.cornerRadius = 22.5
        perLabel.titleLabel!.font = perLabel.titleLabel!.font.withSize(28)// = UIFont(name: "SF-UI-Display-bold", size: 40)
        //        perLabel.center.y = 50
        self.addSubview(perLabel)
        
        
        periodName = UILabel()
        periodName.frame = CGRect(x: 60, y: 10, width: self.frame.width - 80, height: 40)
        periodName.font = UIFont(name: "\(self.periodName.font.fontName)-bold", size: 22)
        periodName.textAlignment = .center
        periodName.text = "Calculus AB"
        self.addSubview(periodName)
        
        
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 10, y: 70, width: self.frame.width - 20, height: 40)
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: self.timeLabel.font.fontName, size: 26)
        timeLabel.text = "7:25 - 8:30"
        self.addSubview(timeLabel)
        
        
        actionButton = UIButton()
        actionButton.frame = CGRect(x: self.frame.width - 34, y: 5, width: 30, height: 30)
        actionButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        actionButton.setTitle("X", for: .normal)
        actionButton.setTitleColor(UIColor.black, for: .normal)
        actionButton.layer.cornerRadius = 15
        
        self.addSubview(actionButton)
        
        addButton = UIButton()
        addButton.setTitle("+", for: .normal)
        addButton.frame = CGRect(x: self.frame.width - 50, y: 135, width: 35, height: 35)
        addButton.backgroundColor = UIColor.lightBlue()
        addButton.layer.cornerRadius = 17.5
//        addButton.layer.backgroundColor = UIColor.white.cgColor
        addButton.layer.borderColor = UIColor.gray.cgColor
        //        cell.layer.borderWidth = 0.0
        //        cell.layer.cornerRadius = 5
        addButton.layer.masksToBounds = false
        //        cell.layer.shadowRadius = 1.0
        addButton.layer.shadowColor = UIColor.lightGray.cgColor
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)//CGSize(1.0, 1.0)
        addButton.layer.shadowOpacity = 0.70
        addButton.layer.shadowRadius = 3.0
        
        
//        actionButton.setTitleColor(UIColor.lightBlue(), for: .normal)
        self.addSubview(addButton)
        
        scroll = UIScrollView()
        scroll.frame = CGRect(x: 0, y: 160, width: self.frame.width, height: self.frame.height - 180)
        scroll.contentSize = CGSize(width: self.frame.width, height: self.frame.height - 180)
//        scroll.backgroundColor = UIColor.green
        self.addSubview(scroll)
//        self.addSubview(assignmentView)
        
//        generateAssignmentView()
        closeExpandedView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPeriodNumber(perNum:Int) {
        self.perLabel.setTitle("\(perNum)", for: .normal)
    }
    
    
    func setPeriodNumber(perNum:Int, color:UIColor) {
        self.perLabel.setTitle("\(perNum)", for: .normal)
        self.perLabel.backgroundColor = color.withAlphaComponent(0.7)
    }
    
    
    func setPeriodName(name:String) {
        self.periodName.text = name
    }
    
    func changeToGray() {
        self.backgroundColor = UIColor.lightGray
    }
    
    func changeToWhite() {
        self.backgroundColor = UIColor.white
    }
    
    
    
    var assignments:[AssignmentView] = []
    func generateAssignmentView(offsetIndex:Int, value:String) {
        let assignmentView = AssignmentView(frame: CGRect(x: 5, y: 60 * offsetIndex + 5, width: Int(self.frame.width - 10), height: 55))
        scroll.contentSize = CGSize(width: self.frame.width, height:  60 * CGFloat(offsetIndex) + 180)
//        assignmentView.backgroundColor = UIColor.green
//        assignmentView.frame =
        assignmentView.assignmentLabel.text = value
        assignments.append(assignmentView)
        self.scroll.addSubview(assignmentView)
     
        
        
    }
    
    
    func initExpandedView (events:[String]) {
        scroll.isHidden = false
        scroll.frame = CGRect(x: 0, y: 180, width: self.frame.width, height: self.frame.height - 190)
        for i in 0 ..< assignments.count {
            assignments[i].removeFromSuperview()
        }
        assignments = []
        
        addButton.isHidden = false
        print("Event Count \(events.count)")
        for i in 0 ..< events.count {
            if events[i] != "" {
                generateAssignmentView(offsetIndex: i, value: events[i])
            }
            
        }
        
    }
    
    func closeExpandedView() {
        scroll.isHidden = true
         addButton.isHidden = true
        for i in 0 ..< assignments.count {
            assignments[i].removeFromSuperview()
        }
        assignments = []
    }
    
}
