//
//  SubContactsCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/3/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class SubContactsCell: UITableViewCell
{
    @IBOutlet  var BrandTitle: UILabel!
    @IBOutlet  var BrandImage: FLImageView!
    @IBOutlet  var BrandDesc: UILabel!
    @IBOutlet  var BrandPlace: UILabel!
    @IBOutlet  var BrandOffer: UILabel!
    @IBOutlet  var BrandContacts: UILabel!
    @IBOutlet  var CallBtn: UIButton!
    @IBOutlet  var MailBtn: UIButton!
    @IBOutlet  var FavBtn: UIButton!
    @IBOutlet  var favImage: UIImageView!
     var compID:String = ""
    var phoneno:String = ""
    var emailid:String = ""
    @IBAction func CallAction(_ sender: AnyObject) {
    }
    @IBAction func MailAction(_ sender: AnyObject) {
    }
    @IBAction func favAction(_ sender: AnyObject) {
    }
    
    public var product: companycontacts?{
        didSet{
            guard let product = product else {
                return
            }
            
             compID =  "\( product.contact_id ?? 0)"
            phoneno =   product.contact_phone!
            emailid =   product.contact_email!
            BrandTitle.text = product.contact_name
           
            BrandPlace.text = product.contact_location
        
            
            let imageURL = product.contact_image
            let trimmedUrl = imageURL?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as! String
            BrandImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
           
            let boolNumber = "\( product.contact_favourite ?? 0)"
            
            let boolString = String(describing: boolNumber)
    
            if (boolString == "0")
            {
                favImage.image = UIImage(named: "star-7")
            }
            else
            {
                favImage.image = UIImage(named: "star-9")
            }
            
            
            let Type = product.contact_type
            
            if (Type == 1) {
                
                BrandDesc.text =  "Company Office"
                
            }
                
            else if (Type == 2)  {
                
            BrandDesc.text = "Sales Office"
                
            }
            else if (Type == 3)  {
                
                BrandDesc.text =  "Service Office"
                
            }
            else if (Type == 4)  {
                
                BrandDesc.text =  "Dealer/Distributor"
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

