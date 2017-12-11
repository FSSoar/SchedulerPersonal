//
//  CustomTableViewCell.swift
//  testingUI
//
//  Created by Avi Arora on 12/10/17.
//  Copyright © 2017 Avi Arora. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var backgroundCardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
