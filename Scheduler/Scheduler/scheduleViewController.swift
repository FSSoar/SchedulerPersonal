//
//  scheduleViewController.swift
//  Scheduler
//
//  Created by Avi Arora on 12/10/17.
//  Copyright © 2017 Himanshu Minocha. All rights reserved.
//

import UIKit

class scheduleViewController: UIViewController {
    var defaults = UserDefaults.standard
    var cards:[CardView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let classes = createPeriodObjects()
        print("from schedule vc")
        print(classes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createPeriodObjects() -> [Period] 
    {
        var classes = [Period]()
        
        for i in 0 ..< 7
        {
            
            if defaults.value(forKey: "period" + String(i)) != nil {
                let dataString = defaults.value(forKey: "period" + String(i)) as! String
                let dataArr = dataString.components(separatedBy: "&&")
                let tempPeriod = Period(className: dataArr[0], period: i + 1)
                classes.append(tempPeriod)
                
                
                
                
            }
           
            
            
        }
        
        for i in 0 ..< 5 {
            let frame = CGRect(x: 10, y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
            let card = CardView(frame: frame)
            
            self.view.addSubview(card)
            
            
        }
        
        return classes
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
