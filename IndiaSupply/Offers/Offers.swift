//
//  Offers.swift
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
import SDWebImage


class Offers: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var OffTitle1:String = ""
    var OffDesc1:String = ""
    var OffPrice1:String = ""
    var OffMRP1:String = ""
    var OffRegularPrice1:String = ""
    var OffTotalSave1:String = ""
    var OffDetails1:String = ""
    var OffImage1:String = ""
    var Offid1:String = ""
    var Offbulk1:String = ""
    
    var height : CGFloat!
    var offerID:String = ""
    var point : CGPoint = CGPoint()
    
    @IBOutlet  var View1: UIView!
    @IBOutlet  var MainScrollView: UIScrollView!

    @IBOutlet  var BannerViewCollection: UICollectionView!
    @IBOutlet  var OffersCollection: UICollectionView!
    
    @IBOutlet var AccountButton : UIButton!
    
    var banners : NSArray  = []
    var offers : NSArray  = []
    
    @IBOutlet  var NoInternetView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         Alamofire.request("https://ha4qf.app.goo.gl/apple-app-site-association", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
         
                }
                break
                
            case .failure(_):
            
                break
                
            }
        }
        self.NoInternetView.isHidden = true
        
        SharedManager.showHUD(viewController: self)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/offers", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
           
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                    
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonOffers")
                    
                    self.NoInternetView.isHidden = true
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonOffers") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                  
                    self.banners = json.object(forKey: "banners") as! NSArray
                    self.offers = json.object(forKey: "offers") as! NSArray
                    
                    self.BannerViewCollection.reloadData()
                    self.OffersCollection.reloadData()
                 
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                SharedManager.dismissHUD(viewController: self)
                self.NoInternetView.isHidden = false
//                if (UserDefaults.standard.object(forKey: "JsonOffers") != nil){
//                    if  let jsond = UserDefaults.standard.object(forKey: "JsonOffers") as? NSData
//
//                    {
//                        let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond as Data) as! NSDictionary
//
//                        self.banners = json.object(forKey: "banners") as! NSArray
//                        self.offers = json.object(forKey: "offers") as! NSArray
//
//                        self.BannerViewCollection.reloadData()
//                        self.OffersCollection.reloadData()
//
//                        SharedManager.dismissHUD(viewController: self)
//                    }}
                break
                
            }
        }
        
        self.BannerViewCollection.frame = CGRect(x: 20, y: BannerViewCollection.frame.origin.y , width: self.view.frame.width - 40 , height:  self.BannerViewCollection.frame.height)
     
        self.OffersCollection.frame = CGRect(x: 0, y: BannerViewCollection.frame.origin.y + self.BannerViewCollection.frame.height + 15 , width: self.view.frame.width , height:  self.OffersCollection.frame.height)
        
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        
        height = self.OffersCollection.collectionViewLayout.collectionViewContentSize.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.OffersCollection.addObserver(self , forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
        
    
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/offers", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                    
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonOffers")
                    
                    self.NoInternetView.isHidden = true
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonOffers") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    self.banners = json.object(forKey: "banners") as! NSArray
                    self.offers = json.object(forKey: "offers") as! NSArray
                    
                    self.BannerViewCollection.reloadData()
                    self.OffersCollection.reloadData()
                    
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                SharedManager.dismissHUD(viewController: self)
                self.NoInternetView.isHidden = false

                break
                
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let newHeight : CGFloat = self.OffersCollection.collectionViewLayout.collectionViewContentSize.height
        
        var frame : CGRect! = self.OffersCollection.frame
        frame.size.height = newHeight
        
        self.OffersCollection.frame = frame
       
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: OffersCollection.frame.size.height + BannerViewCollection.frame.size.height + 20 )
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.OffersCollection.removeObserver(self, forKeyPath: "contentSize")
 
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
    if (collectionView == BannerViewCollection)
    {
        return CGSize(width: self.BannerViewCollection.frame.width , height: self.BannerViewCollection.frame.width + 20   )
    }
    else
    {
     return CGSize(width: self.OffersCollection.frame.width , height: self.view.frame.height / 2.5  )
    }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        if (collectionView == BannerViewCollection)
        {
        return self.banners.count
        }
        else
        {
            return self.offers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if (collectionView == BannerViewCollection)
        {

        let cell = BannerViewCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! OfferBannerCell
        
        let imageURL = (self.banners.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "banner_image") as! String

        cell.OfferImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "place"))
       cell.OfferImage.contentMode = .scaleAspectFit
 
        return cell
      
        }
        else
        {
           
            let cell = OffersCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! OffersCell
            
            let imageURL = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_image") as! String
            
            let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20")
            cell.offerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place1"))
            
            cell.offerTitle.text = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_name") as? String
         
            
            cell.offerDesc.text = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_packaging") as? String
            
            let bulkdesc = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_description") as? String
            if(bulkdesc == "")
            {
                cell.offerBulkDesc.isHidden = true
                cell.offerbulkImage.isHidden = true
            }
            else
            {
            cell.offerBulkDesc.text = bulkdesc
            cell.offerBulkDesc.isHidden = false
            cell.offerbulkImage.isHidden = false
            }
            let OP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_price") as! Int
            cell.offerPrice.text = "Rs." + String(OP)
            
            
            let OMRP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_mrp") as! Int
            let newStringStrike = "Rs." + String(OMRP)
            let attributeString = NSMutableAttributedString(string: newStringStrike)
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            
            cell.OfferMRP.attributedText = attributeString
            
            
            let ORP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_regular_price") as! Int
            let newStringStrike1 = "Rs." + String(ORP)
            let attributeString1 = NSMutableAttributedString(string: newStringStrike1)
            attributeString1.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString1.length))
            cell.OfferRegular.attributedText = attributeString1
            
            
            let OOP = OMRP - OP
            cell.OfferSavings.text =  "Rs." + String(OOP)
            
           
            let OFP = Float(  ( Float(OOP) / Float(OMRP) )) * 100
            let discount = Int(OFP)
            if (discount <= 0)
            {
              cell.Offerlbl.isHidden = true
            }
            else
            {
            cell.Offerlbl.text =  String(discount) + "%" + "Off"
           
            }
            
            
            cell.offerview.layer.shadowOffset = CGSize(width : 0.5, height: 0.5)
            cell.offerview.layer.shadowColor = UIColor.gray.cgColor
            cell.offerview.layer.shadowRadius = 4
            cell.offerview.layer.shadowOpacity = 0.5
            cell.offerview.layer.masksToBounds = false
            cell.offerview.clipsToBounds = false
          
            cell.sendEnquiryBtn.layer.cornerRadius = 4.0
            cell.sendEnquiryBtn.backgroundColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
            
            cell.Offerdetails.textColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
       
            cell.Offerdetails.underline()
 
            
            cell.offerBulkDesc.textColor = UIColor(red: 159 / 255 , green: 122 / 255, blue: 109 / 255, alpha:1)
            
            cell.sendEnquiryBtn.addTarget(self, action: #selector(Offers.inquiredesc(_:)), for: UIControlEvents.touchUpInside)
            cell.sendEnquiryBtn.tag = (indexPath as NSIndexPath).row
            
            cell.offerTitle.frame = CGRect(x: cell.offerTitle.frame.origin.x, y: cell.offerTitle.frame.origin.y  , width: cell.offerTitle.frame.width, height: cell.offerTitle.frame.size.height)
            cell.offerTitle.sizeToFit()
            
            cell.offerDesc.frame = CGRect(x: cell.offerDesc.frame.origin.x, y: cell.offerTitle.frame.origin.y + cell.offerTitle.frame.height + 3, width: cell.offerDesc.frame.width, height: cell.offerDesc.frame.size.height)
            cell.offerDesc.sizeToFit()
            
            cell.offerBulkDesc.frame = CGRect(x: cell.offerBulkDesc.frame.origin.x, y: cell.offerDesc.frame.origin.y + cell.offerDesc.frame.height + 7, width: cell.offerBulkDesc.frame.width, height: cell.offerBulkDesc.optimalHeight)
            
            cell.offerbulkImage.frame = CGRect(x: cell.offerbulkImage.frame.origin.x, y: cell.offerDesc.frame.origin.y + cell.offerDesc.frame.height + 7, width: cell.offerbulkImage.frame.width, height: cell.offerbulkImage.frame.size.height)
            
            let  screenWidth = self.view.frame.size.width
            
            let screensize = Int (screenWidth)
            
            switch (screensize) {
            case 320: // iPhone 4 and iPhone 5
                
                cell.offerTitle.font = UIFont(name: "AvenirNextLTPro-Demi", size: 13)
                cell.offerDesc.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
                cell.offerBulkDesc.font = UIFont(name: "AvenirNextLTPro-Demi", size: 13)
                
                cell.offerPrice.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
                cell.OfferMRP.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.OfferRegular.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.OfferSavings.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.Offerlbl.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.Offerdetails.font = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
               
                cell.offerPrice1.font = UIFont(name: "AvenirNextLTPro-Demi", size: 12)
                cell.OfferMRP1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.OfferRegular1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                cell.OfferSavings1.font = UIFont(name: "AvenirNextLTPro-Regular", size: 12)
                
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
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if (collectionView == BannerViewCollection)
        {
            
        }
        else
        {
       self.OffImage1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_image") as! String
      
        self.OffTitle1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_name") as! String
        
        self.OffDesc1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_packaging") as! String
       
        
        self.Offbulk1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_description") as! String
            
        let OP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_price") as! Int
        self.OffPrice1 = "Rs." + String(OP)
        
        let OMRP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_mrp") as! Int
        self.OffMRP1 = "Rs." + String(OMRP)
        
        let ORP = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_regular_price") as! Int
        self.OffRegularPrice1 = "Rs." + String(ORP)
        
        let OOP = OMRP - OP
       self.OffTotalSave1 = "Rs." + String(OOP)
        
        self.OffImage1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_image") as! String
     
        self.OffDetails1 = (self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_html_details") as! String
       
        self.Offid1 = String((self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_id") as! Int)
        
        self.performSegue(withIdentifier: "details", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "details")
        {
            let obj:OfferDetails = segue.destination as! OfferDetails
            
            obj.OffTitle = self.OffTitle1
            obj.OffDesc = self.OffDesc1
            obj.OffPrice = self.OffPrice1
            obj.OffMRP = self.OffMRP1
            obj.OffRegularPrice = self.OffRegularPrice1
            obj.OffTotalSAve = self.OffTotalSave1
            obj.OffDetails = self.OffDetails1
            obj.OffImage = self.OffImage1
            obj.OffID = self.Offid1
            obj.Offbulk = self.Offbulk1
        }else if(segue.identifier == "buynow"){
            let obj:OrderDetails = segue.destination as! OrderDetails
            
            obj.OffID = self.offerID
        }
    }
    
    @IBAction func accountAction(_ sender : UIButton) {
        self.performSegue(withIdentifier: "accounts", sender: self)
    }
    
    @objc func inquiredesc(_ sender : UIButton)
    {
        point = sender.convert(CGPoint.zero, to: self.OffersCollection as UIView)
        let indexPath: IndexPath! = self.OffersCollection.indexPathForItem(at: point)
        
        self.offerID = String((self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_id") as! Int)
        
        self.performSegue(withIdentifier: "buynow", sender: self)
    }
    
    /*@objc func inquiredesc(_ sender : UIButton)
    {
        SharedManager.showHUD(viewController: self)
        
        point = sender.convert(CGPoint.zero, to: self.OffersCollection as UIView)
        let indexPath: IndexPath! = self.OffersCollection.indexPathForItem(at: point)
        
        self.offerID = String((self.offers.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "offer_id") as! Int)
        
     let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["offer_id": self.offerID ]
        
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
        
    }*/
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
