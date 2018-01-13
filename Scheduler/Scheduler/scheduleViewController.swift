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
    
    @IBOutlet var topView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let classes = createPeriodObjects()
        print("from schedule vc")
        print(classes)
        // Do any additional setup after loading the view.
        self.topView.layer.backgroundColor = UIColor.white.cgColor
        self.topView.layer.borderColor = UIColor.gray.cgColor
        //        cell.layer.borderWidth = 0.0
        //        cell.layer.cornerRadius = 5
        self.topView.layer.masksToBounds = false
        //        cell.layer.shadowRadius = 1.0
        self.topView.layer.shadowColor = UIColor.lightGray.cgColor
        self.topView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)//CGSize(1.0, 1.0)
        self.topView.layer.shadowOpacity = 0.70
        self.topView.layer.shadowRadius = 3.0
        
        
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
        var periods:[String] = ["AP Calculus AB", "AP Physics C", "AP Government", "Independent Study: AI", "AP Psychology"]
        var colors:[UIColor] = [UIColor.appleRed(), UIColor.appleBlue(), UIColor.applePink(), UIColor.appleGreen(), UIColor.appleOrange()]
        for i in 0 ..< 5 {
            let frame = CGRect(x: 10, y: (Int)(140 * i + 95), width: (Int)(self.view.frame.width - 20), height: 125)
            let card = CardView(frame: frame)
            card.setPeriodName(name: periods[i])
//            card.setPeriodNumber(perNum: i + 1)
            card.setPeriodNumber(perNum: i + 1, color: colors[i])
            
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
