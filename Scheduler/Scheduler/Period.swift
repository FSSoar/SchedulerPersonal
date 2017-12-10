//
//  Period.swift
//  Scheduler
//
//  Created by Himanshu Minocha on 10/24/17.
//  Copyright © 2017 Himanshu Minocha. All rights reserved.
//

import UIKit

class Period: NSObject {

    var className:String = ""
    var period:Int = 0;
    var subject:String = ""
    
     init(className:String, period:Int) {
        self.className = className
        self.period = period
//        self.subject = subject
    }
    
}
