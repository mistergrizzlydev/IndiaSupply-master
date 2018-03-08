//
//  TableCellFav.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/24/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class TableCellFav: UITableViewCell
{
    @IBOutlet  var BrandTitle: UILabel!
    @IBOutlet  var BrandImage: FLImageView!
    @IBOutlet  var BrandDesc: UILabel!
    @IBOutlet  var BrandPlace: UILabel!
   
    @IBOutlet  var CallBtn: UIButton!
    @IBOutlet  var MailBtn: UIButton!
    
    @IBAction func CallAction(_ sender: AnyObject) {
    }
    @IBAction func MailAction(_ sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}




