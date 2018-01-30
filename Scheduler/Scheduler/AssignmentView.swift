//
//  AssignmentView.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 1/29/18.
//  Copyright © 2018 Himanshu Minocha. All rights reserved.
//

import UIKit

class AssignmentView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    var checkButton:UIButton!
    var assignmentLabel:UILabel!
    
    override func awakeFromNib() {
        
        
        self.backgroundColor = UIColor.green
        self.layer.cornerRadius = 15
        
        
        

   
        
        
        
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        checkButton = UIButton()
        checkButton.frame = CGRect(x: 10, y: 5, width: 45, height: 45)
//        perLabel1.center.y
//        checkButton.setTitle("1", for: .normal)
        checkButton.layer.cornerRadius = 22.5
        checkButton.layer.borderColor = UIColor.lightBlue().cgColor
        checkButton.layer.borderWidth = 3
        checkButton.layer.backgroundColor = UIColor.white.cgColor
//        checkButton.backgroundColor = UIColor.red.cgColor
//        checkButton.layer.cornerRadius = 22.5
        checkButton.titleLabel!.font = checkButton.titleLabel!.font.withSize(28)// = UIFont(name: "SF-UI-Display-bold", size: 40)
        //        perLabel.center.y = 50
        //        self.addSubview()
        
        self.addSubview(checkButton)
        
        assignmentLabel = UILabel()
        assignmentLabel.frame = CGRect(x: self.checkButton.frame.origin.x + 45 +  10, y: 10, width: self.frame.width - 30, height: 40)
        assignmentLabel.text = "THIS IS TEXT"
        self.addSubview(assignmentLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
