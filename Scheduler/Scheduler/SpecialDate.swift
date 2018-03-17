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
    
    /**
     * KEY FOR SPECIAL DATES
     * E = Early Release
     * A = Advisory
     * N = No School
     * AD = Early Dismissal
     *
    **/
    
    
    
    init(date:Date, reason:String, type:String)
    {
        self.date = date
        self.reason = reason
        self.type = type
        
    }
    
    
    
    
    func returnTimeArray(keyCode:String) -> [String] {
        if keyCode == "E" {
            return ["7:25 - 8:09", "8:14 - 8:58", "9:03 - 9:47", "9:52 - 10:36", "10:41 - 11:25"]
        }
        else if keyCode == "A" {
            return ["7:25 - 8:25", "8:30 - 9:25", "9:30 - 9:50", "9:55 - 10:50", "10:55 - 12:45", "12:50 - 1:50"]
            
        }
        else if keyCode == "N" {
            return []
            
        }
        else if keyCode == "AD" {
            return["7:25 - 8:05", "8:10 - 8:45", "8:50 - 9:25", "9:30 - 10:05", "10:10 - 10:45"]
            
        }
        else {
            return []
        }
    }
    
}
