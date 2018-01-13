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
        periodName.frame = CGRect(x: 0, y: 10, width: self.frame.width - 20, height: 40)
        periodName.font = UIFont(name: "\(self.periodName.font.fontName)-bold", size: 28)
        periodName.textAlignment = .center
        periodName.text = "Calculus AB"
        self.addSubview(periodName)
        
        
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 10, y: 70, width: self.frame.width - 20, height: 40)
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: self.timeLabel.font.fontName, size: 26)
        timeLabel.text = "7:25 - 8:30"
        self.addSubview(timeLabel)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPeriodNumber(perNum:Int) {
        self.perLabel.setTitle("\(perNum)", for: .normal)
    }
    
    
    func setPeriodNumber(perNum:Int, color:UIColor) {
        self.perLabel.setTitle("\(perNum)", for: .normal)
    }
    
    
    func setPeriodName(name:String) {
        self.periodName.text = name
    }
    
}
