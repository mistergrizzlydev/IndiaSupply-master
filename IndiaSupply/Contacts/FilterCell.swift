//
//  FilterCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/21/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell
{
    
    @IBOutlet  var FilterTitle: UILabel!
    @IBOutlet  var FilterBtn: UIImageView!
    
    public var product: CategoryDetail?{
        didSet{
            guard let product = product else {
                return
            }
            
            
            FilterTitle.text = product.category_name
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

