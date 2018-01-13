//
//  SpecialDate.swift
//  Scheduler
//
//  Created by Avi Arora on 1/13/18.
//  Copyright © 2018 Himanshu Minocha. All rights reserved.
//

import UIKit

class SpecialDate: NSObject {
    
    var date:Date
    var reason:String = ""
    var type:String = ""
    
    init(date:Date, reason:String, type:String)
    {
        self.date = date
        self.reason = reason
        self.type = type
        
    }
    
}
