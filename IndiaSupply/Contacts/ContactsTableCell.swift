//
//  ExhibiterTableCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/3/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class ContactsTableCell: UITableViewCell
{
    @IBOutlet  var BrandTitle: UILabel!
    @IBOutlet  var BrandImage: FLImageView!
    @IBOutlet  var BrandSpec: UILabel!
    @IBOutlet  var BrandContacts: UILabel!
          var compID:String = ""
    var companiesdetailsarray : NSArray  = []
    public var product: companiesDetail?{
        didSet{
            guard let product = product else {
                return
            }
           
             compID =  "\( product.company_id ?? 0)"
            BrandTitle.text = product.company_name
            BrandSpec.text = product.company_categories
            
            let counts = product.company_contacts?.count
            BrandContacts.text = "\( counts ?? 0) CONTACTS"
            
            companiesdetailsarray = product.company_contacts as! NSArray
            let imageURL = product.company_image
            let trimmedUrl = imageURL?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as! String
            BrandImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "Brandicon"))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }


}
