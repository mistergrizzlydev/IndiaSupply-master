//
//  DateCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/16/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell
{
    @IBOutlet  var DateImage: FLImageView!
    @IBOutlet  var DateLbl: UILabel!
    
    @IBOutlet  var BLbl: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
               self.BLbl.isHidden = false
            }
            else {
                self.BLbl.isHidden = true
            }
        }
    }
   
    
}


