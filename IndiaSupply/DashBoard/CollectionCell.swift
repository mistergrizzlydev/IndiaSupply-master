//
//  CollectionCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/27/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell
{
    @IBOutlet  var BannerImage: FLImageView!
    @IBOutlet  var BrandTitle: UILabel!
  
     var bannertype:String = ""
     var bannertypeid:String = ""
    
    public var product: bannerDetail?{
        didSet{
            guard let product = product else {
                return
            }
            
             bannertype =  "\( product.banner_type ?? 0)"
             bannertypeid =  "\( product.banner_type_id ?? 0)"
            
            let imageURL = product.banner_image
            let trimmedUrl = imageURL?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as! String
            BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
            
            let Enq =   product.banner_title
            if (Enq == "")
            {
               BrandTitle.isHidden = true
                
            }
            else
            {
                BrandTitle.text = product.banner_title
                
            }
        }
    }
}

