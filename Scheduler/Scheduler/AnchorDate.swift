//
//  AnchorDate.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 1/17/18.
//  Copyright © 2018 Himanshu Minocha. All rights reserved.
//

import UIKit

class AnchorDate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var date:Date!
    var day:Int = -1
    
    init(date:Date, day:Int) {
        self.date = date
        self.day = day
    }

}
