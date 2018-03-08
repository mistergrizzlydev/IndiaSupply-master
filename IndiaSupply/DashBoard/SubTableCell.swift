//
//  SubTableCell.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/28/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//
import UIKit

class SubTableCell: UITableViewCell
{
    @IBOutlet  var ProTitle: UILabel!
    @IBOutlet  var Add: UIButton!
    @IBOutlet  var ProDesc: UILabel!
    @IBOutlet  var ProPack: UILabel!
    @IBOutlet  var ProPrice: UILabel!
    var count:Int = 0
    @IBOutlet  var descTitle: UILabel!
    
    var productid:String = ""
    @IBAction func InquireAction(_ sender: AnyObject) {
    }
    public var product: ProductArray?{
        didSet{
            guard let product = product else {
                return
            }

            productid = " \(product.product_id ?? 0)"
            
            ProTitle.text = product.product_name
            ProDesc.text = product.product_description
            ProPack.text = product.product_packaging
            ProPrice.text = product.product_price
            descTitle.isHidden = true

            
             self.ProTitle.frame.size.height = self.ProTitle.optimalHeight
             self.ProDesc.frame.size.height = self.ProDesc.optimalHeight
             self.ProPack.frame.size.height = self.ProPack.optimalHeight
             self.ProPrice.frame.size.height = self.ProPrice.optimalHeight
          
              self.ProTitle.frame = CGRect(x: self.ProTitle.frame.origin.x, y: self.ProTitle.frame.origin.y + 5 , width: self.ProTitle.frame.width, height: self.ProTitle.optimalHeight)
            
            self.ProDesc.frame = CGRect(x: self.ProDesc.frame.origin.x, y: self.ProTitle.frame.origin.y + ProTitle.frame.size.height + 5, width: self.ProDesc.frame.width, height: self.ProDesc.optimalHeight)
            
            self.ProPack.frame = CGRect(x: self.ProPack.frame.origin.x, y: self.ProDesc.frame.origin.y + ProDesc.frame.size.height + 5, width: self.ProPack.frame.width, height: self.ProPack.optimalHeight)
            
            self.ProPrice.frame = CGRect(x: self.ProPrice.frame.origin.x, y: self.ProPack.frame.origin.y + ProPack.frame.size.height + 5, width: self.ProPrice.frame.width, height: self.ProPrice.optimalHeight)
            
            let Enqdesc = product.product_description as! String
            
            if (Enqdesc == "If you have any other inquiry apart from the ones listed above, please inquire them here.")
            {
                descTitle.text = product.product_description
                ProTitle.text = ""
                ProDesc.text = ""
                ProPack.text = ""
                ProPrice.text = ""
                descTitle.isHidden = false
                var val : Int = (descTitle.text?.count)!
                if (val >= 70)
                {
                    var abcmore : String =  (descTitle.text as! NSString).substring(with: NSRange(location: 0, length: 70))
                    abcmore += "...more"
                    descTitle.text = abcmore
                    var attribs = [NSAttributedStringKey.foregroundColor: UIColor.blue]
                    var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: abcmore)
                    //attributedString.addAttribute(NSAttributedStringKey.link, value: "...ReadMore", range: NSRange(location: 70, length: 11))
                    //attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 70, length: 11))
                    attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location: 70, length: 7))
                    descTitle.attributedText = attributedString
                    
                    var abcless : String =  (product.product_description as! NSString).substring(with: NSRange(location: 0, length: 89))
                    abcless += "...less"
                    //descTitle.text = abcless
                    var attribs2 = [NSAttributedStringKey.foregroundColor: UIColor.blue]
                    var attributedString2: NSMutableAttributedString = NSMutableAttributedString(string: abcless)
                    
                    //attributedString2.addAttribute(NSAttributedStringKey.link, value: "...ReadLess", range: NSRange(location: 89, length: 11))
                    //attributedString2.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 89, length: 11))
                    attributedString2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location: 89, length: 7))
                    
                    //descTitle.attributedText = attributedString2
                    let attributedval1 = attributedString
                    let s = attributedval1.string
                    let attributedval2 = attributedString2
                    let s2 = attributedval2.string
                    descTitle.isUserInteractionEnabled = true // Remember to do this
                    let tap: MyTapGesture = MyTapGesture(
                        target: self, action: #selector(labelMore))
                    descTitle.addGestureRecognizer(tap)
                    
                    if(count == 0){
                        tap.title1 = s
                        tap.title2 = s2
                        count = 1
                    }
                    tap.delegate = self
                }
            }
           
            
            let Enq = product.product_enquiry
            if (Enq == 1)
            {
                let image = UIImage(named: "tick")
                Add.setImage(image, for: .normal)
                Add.setTitle("",for: .normal)
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Add.layer.borderWidth = 1.0
        Add.layer.cornerRadius = 3
        Add.layer.borderColor = UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1).cgColor
        Add.setTitleColor(UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1), for: .normal)
        
    }
    
    @objc func labelMore(sender: MyTapGesture) {
        if(count == 1){
            var attributedString1: NSMutableAttributedString = NSMutableAttributedString(string: sender.title2)
            attributedString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location: 89, length: 7))
            descTitle.attributedText = attributedString1
            count = 0
        }else if(count == 0){
            var attributedString2: NSMutableAttributedString = NSMutableAttributedString(string: sender.title1)
            attributedString2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: NSRange(location: 70, length: 7))
            descTitle.attributedText = attributedString2
            count = 1
        }
        
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var title1 = String()
        var title2 = String()
    }
    
    
}
extension UILabel
{
    var optimalHeight : CGFloat
    {
        get
        {
            let label = UILabel(frame: CGRect( x : 0, y : 0, width : self.frame.width , height : CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            
            label.sizeToFit()
            
            return label.frame.height
        }
    }
}

