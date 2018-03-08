//
//  TableCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/26/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//
import UIKit

class TableCell: UITableViewCell
{
    @IBOutlet  var BrandTitle: UILabel!
    @IBOutlet  var BrandImage: FLImageView!
    @IBOutlet  var BrandSpec: UILabel!
    @IBOutlet  var BrandRate: UILabel!
    @IBOutlet  var BrandOffer: UILabel!
    @IBOutlet  var BrandContacts: UILabel!
    @IBOutlet  var BrandStar: UIImageView!
    var compID:String = ""
    public var product: companyDetail? {
        didSet{
            guard let product = product else {
                return
            }
   
            compID =  "\( product.company_id ?? 0)"
            
            BrandTitle.text = product.company_name
            BrandSpec.text = product.company_categories
           
            BrandOffer.text = " \(product.total_offers ?? 0)"
            BrandContacts.text = "\( product.total_products ?? 0) PRODUCTS"
            
            let imageURL = product.company_image
            let trimmedUrl = imageURL?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as! String
            BrandImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
            
            let Enq =   product.total_offers
            if (Enq == 0)
            {
                BrandOffer.isHidden = true
                
            }
            else
            {
                 BrandOffer.text = " \(product.total_offers ?? 0) OFFERS"
                
            }
            
            let rate =   product.total_ratings
            if (rate ==  0)
            {
                BrandRate.isHidden = true
                BrandStar.isHidden = true
            }
            else
            {
                BrandRate.isHidden = true
                BrandStar.isHidden = true
          //      BrandRate.text = " \(product.total_ratings ?? 0)"
                
            }
            
        }
    }

    override func awakeFromNib() {
    super.awakeFromNib()
    }
        
}
