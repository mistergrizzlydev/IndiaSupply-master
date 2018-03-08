 //
//  OffersDetails.swift
//  IndiaSupply
//
//  Created by Shikha Sharma on 2/16/18.
//  Copyright © 2018 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import ObjectMapper
import AlamofireObjectMapper

class OfferDetails: UIViewController {
  
    var OffID:String = ""
    var OffTitle:String = ""
    var OffDesc:String = ""
    var OffPrice:String = ""
    var OffMRP:String = ""
    var OffRegularPrice:String = ""
    var OffTotalSAve:String = ""
    var OffDetails:String = ""
    var OffImage:String = ""
    var Offbulk:String = ""
    
    @IBOutlet  var offerImage: FLImageView!
    @IBOutlet  var offerTitle: UILabel!
    @IBOutlet  var offerDesc: UILabel!
    @IBOutlet  var offerPrice: UILabel!
    @IBOutlet  var OfferMRP: UILabel!
    @IBOutlet  var OfferRegular: UILabel!
    @IBOutlet  var OfferSavings: UILabel!
    @IBOutlet  var Offerlbl: UILabel!
    @IBOutlet  var Offerdetails: UILabel!
    @IBOutlet  var sendEnquiryBtn: UIButton!
    @IBOutlet  var Offerdet: UILabel!
    @IBOutlet  var offerBulkDesc: UILabel!
    @IBOutlet  var offerbulkImage: UIImageView!
    
    @IBOutlet  var MainScrollView: UIScrollView!

    @IBOutlet  var offerPrice1: UILabel!
    @IBOutlet  var OfferMRP1: UILabel!
    @IBOutlet  var OfferRegular1: UILabel!
    @IBOutlet  var OfferSavings1: UILabel!
    @IBOutlet  var OfferDetail: UILabel!
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
     let trimmedUrl = OffImage.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20")
    offerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place1"))
    
    offerTitle.text = OffTitle
    offerDesc.text = OffDesc

    if(Offbulk == "")
    {
        offerBulkDesc.isHidden = true
        offerbulkImage.isHidden = true
    }
    else
    {
        offerBulkDesc.text = Offbulk
        offerBulkDesc.textColor = UIColor(red: 159 / 255 , green: 122 / 255, blue: 109 / 255, alpha:1)
        
        offerBulkDesc.isHidden = false
        offerbulkImage.isHidden = false
    }
   
    offerPrice.text = OffPrice

    let newStringStrike = OffMRP
    let attributeString = NSMutableAttributedString(string: newStringStrike)
    attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
    OfferMRP.attributedText = attributeString
    

    let newStringStrike1 = OffRegularPrice
    let attributeString1 = NSMutableAttributedString(string: newStringStrike1)
    attributeString1.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString1.length))
    OfferRegular.attributedText = attributeString1
    
    OfferSavings.text =  OffTotalSAve
    
    
    let OOP = OffTotalSAve.replacingOccurrences(of: "Rs.", with: "")
    
    let OMRP = OffMRP.replacingOccurrences(of: "Rs.", with: "")
    
    let OFP = Float(  ( Float(OOP)! / Float(OMRP)! )) * 100
    let discount = Int(OFP)

    
    if (discount <= 0)
    {
        Offerlbl.isHidden = true
    }
    else
    {
        Offerlbl.text =  String(discount) + "%" + "Off"
    }
    
    sendEnquiryBtn.backgroundColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
    
    if (OffDetails == "")
    {
        Offerdet.isHidden = true
        Offerdetails.isHidden = true
    }
    else
    {
   let newhtmlstring = OffDetails.decodingHTMLEntities()
    
    let str = newhtmlstring.replacingOccurrences(of: "<ul>", with: "", options: String.CompareOptions.regularExpression, range: nil)
   
    let str1 = str.replacingOccurrences(of: "<li>", with: "• ", options: String.CompareOptions.regularExpression, range: nil)
    
    let str2 = str1.replacingOccurrences(of: "</li>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    
    let str3 = str2.replacingOccurrences(of: "</ul>", with: "", options: String.CompareOptions.regularExpression, range: nil)
  
    Offerdetails.text = str3

    }
    self.updateframes()
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
  
    func updateframes() {
    
        self.Offerdetails.frame = CGRect(x: self.Offerdetails.frame.origin.x, y: self.Offerdetails.frame.origin.y , width: self.Offerdetails.frame.width, height: self.Offerdetails.optimalHeight)

        self.offerTitle.frame = CGRect(x: self.offerTitle.frame.origin.x, y: self.offerTitle.frame.origin.y  , width: self.offerTitle.frame.width, height: self.offerTitle.optimalHeight)
        self.offerTitle.sizeToFit()

        self.offerDesc.frame = CGRect(x: self.offerDesc.frame.origin.x, y: self.offerTitle.frame.origin.y + self.offerTitle.frame.height + 3, width: self.offerDesc.frame.width, height: self.offerDesc.optimalHeight)
      //  self.offerDesc.sizeToFit()
//
        self.offerBulkDesc.frame = CGRect(x: self.offerBulkDesc.frame.origin.x, y: self.offerDesc.frame.origin.y + self.offerDesc.frame.height + 7, width: self.offerBulkDesc.frame.width, height: self.offerBulkDesc.optimalHeight)

        
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: offerTitle.frame.size.height + self.offerDesc.frame.size.height + offerBulkDesc.frame.size.height + offerPrice.frame.size.height + 20 + OfferMRP.frame.size.height  + OfferRegular.frame.size.height  + OfferSavings.frame.size.height + 20 + Offerdetails.frame.size.height + 20 + Offerdet.frame.size.height + 20 )
        
        let  screenWidth = self.view.frame.size.width
        
        let screensize = Int (screenWidth)
        
        switch (screensize) {
        case 320: // iPhone 4 and iPhone 5
            
            self.offerTitle.font = UIFont(name: "AvenirNextLTPro-Demi", size: 13)
            self.offerDesc.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
            self.offerBulkDesc.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
            
            self.offerPrice.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
            self.OfferMRP.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.OfferRegular.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.OfferSavings.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.Offerlbl.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.Offerdetails.font = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
            
            self.offerPrice1.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
            self.OfferMRP1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.OfferRegular1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.OfferSavings1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.OfferDetail.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            self.Offerdetails.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
            
            self.offerbulkImage.frame = CGRect(x: self.offerbulkImage.frame.origin.x, y: self.offerBulkDesc.frame.origin.y , width: 12 , height: 12)
            
            break
            
        case 375: // iPhone 6/7
            break
            
        case 414: // iPhone 6/7 Plus
            break
            
        case 768: // iPad
            break
            
        default:
            break // iPad Pro
            
        }
    }
    
    
    @IBAction func InquireBtnAction(_ sender: AnyObject)
    {
        SharedManager.showHUD(viewController: self)
        
           let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["offer_id": OffID ]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry2", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let json = data as! NSDictionary
                    
                    let message = json.object(forKey: "message") as! String
                    
                    
                    let alert = UIAlertController(title:nil, message:message, preferredStyle: UIAlertControllerStyle.alert)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    let when = DispatchTime.now() + 2.0
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                    
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                 SharedManager.dismissHUD(viewController: self)
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                break
                
            }
        }
        
        
    }
}
 
 
 extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        
        return htmlToAttributedString?.string ?? ""
    }
    
 }


