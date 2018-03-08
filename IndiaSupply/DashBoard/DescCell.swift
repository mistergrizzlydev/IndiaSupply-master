//
//  DescCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/28/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class DescCell: UICollectionViewCell
{
    @IBOutlet  var ProImage: FLImageView!
    @IBOutlet  var ProTitle: UILabel!
    @IBOutlet  var ProDesc: UILabel!
    @IBOutlet  var ProSpecial: UILabel!
    @IBOutlet  var ProPack: UILabel!
    @IBOutlet  var AddBtn: UIButton!
    var productid:String = ""
    @IBAction func InquiredAction(_ sender: AnyObject) {
    }
    public var product: ProductArray?{
        didSet{
            guard let product = product else {
                return
            }
            productid = " \(product.product_id ?? 0)"
            ProTitle.text = product.product_name
            ProSpecial.text = product.product_price
            ProDesc.text = product.product_description
            ProPack.text = product.product_packaging
            
            let Enq = product.product_enquiry
 
            if (Enq == 1)
            {
                let image = UIImage(named: "tick")
                AddBtn.setImage(image, for: .normal)
                AddBtn.setTitle("",for: .normal)
                
            }
            let imageURL = product.product_image
            let trimmedUrl = imageURL?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as! String
            ProImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
            
        
        }
    }
}

