//
//  InfoTableCell.swift
//  IndiaSupply
//
//  Created by Shikha Sharma on 2/27/18.
//  Copyright © 2018 Samarjeet. All rights reserved.
//

import UIKit

class InfoTableCell: UITableViewCell {
    
   
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var webHeightConstraint: NSLayoutConstraint!
    
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.frame.size.height = 45.0
                
            } else {
                self.frame.size.height = 128.0
            }
        }
    }
}
