//
//  EventView.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/4/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDynamicLinks
import Firebase
import MobileCoreServices

class EventView: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource
{
    var height : CGFloat!
    
    var indID:String = ""
   
    var EventPreID:String = ""

    @IBOutlet  var cityBtn : UIButton!
    
    @IBOutlet  var NoInternetView : UIView!
    
    @IBOutlet  var View1: UIView!
    @IBOutlet  var CardCollection: UICollectionView!
    @IBOutlet  var MainScrollView: UIScrollView!

    @IBOutlet  var CityTable: UITableView!
    
    @IBOutlet  var lbl1: UILabel!
    
    var Eventlist : NSArray  = []
    var Eventlist1 : NSArray  = []
    
    @IBOutlet  var Cityvv : UIView!
    @IBOutlet  var CityView : UIView!
    var EventCityArray : NSArray  = []
    @IBOutlet  var selectAllBtn : UIButton!
    @IBOutlet  var deselectAllBtn : UIButton!
    @IBOutlet  var cancelBtn : UIButton!
    @IBOutlet  var applyBtn : UIButton!
    
    var Eventlistfilter: [Any] = []
   
    var filtered : NSArray  = []
   var selectedCity : [String] = []
    
    static let DYNAMIC_LINK_DOMAIN = "ha4qf.app.goo.gl"
  
     var longLink: URL?
    var shortLink: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        CityView.isHidden = true
        Cityvv.layer.cornerRadius = 6.0
        
        self.NoInternetView.isHidden = true
        SharedManager.showHUD(viewController: self)
        
        cityBtn.semanticContentAttribute = .forceRightToLeft
        cityBtn.layer.cornerRadius = 5.0
        cityBtn.layer.borderColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1).cgColor
        cityBtn.layer.borderWidth = 2.0
        
        
        selectAllBtn.setTitleColor(UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1), for: .normal)
        deselectAllBtn.setTitleColor(UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1), for: .normal)
        cancelBtn.setTitleColor(UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1), for: .normal)
        applyBtn.setTitleColor(UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1), for: .normal)
        
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/events", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                      self.NoInternetView.isHidden = true
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonEvents")
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonEvents") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    self.Eventlist = json.object(forKey: "events") as! NSArray
                    self.Eventlist1 = json.object(forKey: "events") as! NSArray
                    self.EventCityArray = self.Eventlist.value(forKey: "event_city") as! NSArray
                   
                    let set = NSSet(array: self.EventCityArray as [AnyObject])
                
                    self.EventCityArray = set.allObjects as NSArray
                    
                    self.EventCityArray = self.EventCityArray.sorted { ($0 as! String).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending } as NSArray


                    self.CityTable.reloadData()
                    self.CardCollection.reloadData()
                      SharedManager.dismissHUD(viewController: self)
                    
                    if (UserDefaults.standard.object(forKey: "EventPreID") == nil)
                    {
                        
                    }
                    else
                    {
                        
                        self.dynamicLink()
                    }
                }
                break
                
            case .failure(_):
                SharedManager.dismissHUD(viewController: self)
//                if (UserDefaults.standard.object(forKey: "JsonEvents") != nil){
//                    if  let jsond = UserDefaults.standard.object(forKey: "JsonEvents") as? NSData
//
//                    {
//                        let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond as Data) as! NSDictionary
//
//                        self.Eventlist = json.object(forKey: "events") as! NSArray
//
//                        self.CardCollection.reloadData()
//                        SharedManager.dismissHUD(viewController: self)
//                    }}
                self.NoInternetView.isHidden = false
                
                break
                
            }
        }
        
        CardCollection.frame =  CGRect(x: 10, y: 0, width: self.view.frame.size.width - 20, height: CardCollection.frame.size.height )
        
        self.flowLayout()


        lbl1.frame =  CGRect(x: -10, y:View1.frame.size.height - 2, width: self.view.frame.size.width + 20, height: 0.9)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
       height = self.CardCollection.collectionViewLayout.collectionViewContentSize.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    
        super.viewWillAppear(true)

        self.CardCollection.addObserver(self , forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)

  
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/events", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                    self.NoInternetView.isHidden = true
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonEvents")
                   
                    let jsond = UserDefaults.standard.object(forKey: "JsonEvents") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    self.Eventlist = json.object(forKey: "events") as! NSArray
                    
                    self.Eventlist1 = json.object(forKey: "events") as! NSArray
                    self.EventCityArray = self.Eventlist.value(forKey: "event_city") as! NSArray
                    
                    let set = NSSet(array: self.EventCityArray as [AnyObject])
                    
                    self.EventCityArray = set.allObjects as NSArray
                    
                    self.EventCityArray = self.EventCityArray.sorted { ($0 as! String).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending } as NSArray
                    
                    
                    self.CityTable.reloadData()
                    self.CardCollection.reloadData()
                    
                    SharedManager.dismissHUD(viewController: self)
                    
                    if (UserDefaults.standard.object(forKey: "EventPreID") == nil)
                    {
                        
                    }
                    else
                    {
                        
                        self.dynamicLink()
                    }
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

            let newHeight : CGFloat = self.CardCollection.collectionViewLayout.collectionViewContentSize.height

            var frame : CGRect! = self.CardCollection.frame
            frame.size.height = newHeight

            self.CardCollection.frame = frame

            self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: CardCollection.frame.size.height + 20 )

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    self.CardCollection.removeObserver(self, forKeyPath: "contentSize")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Eventlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = CardCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CardCell
   
        
        let imageURL = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_image") as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
      
        cell.PlaceLbl.text = NSString(format:"%@",((Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_name") as? String)! ) as String
        
       
         cell.venueLbl.text = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_venue") as? String
        
        let IntStr = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_interested") as! Int
        
        if(IntStr == 0 )
        {}
        else
        {
        let image = UIImage(named: "likefilled")
        cell.InterestedBtn.setImage(image, for: .normal)
        cell.InterestedBtn.setTitle("  Interested",for: .normal)
        }
        
        let dateStr = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_start_date") as? String
        
        let dateStr1 = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_end_date") as? String
        
        if (dateStr == dateStr1 )
        {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd "
            let s1 = dateFormatter1.date(from: dateStr1!)
            dateFormatter1.dateFormat = "dd MMM"
            
            
            cell.DateLbl.text =  NSString(format:"%@ , %@ ", dateFormatter1.string(from: s1!), ((Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_city")) as! String) as String
           
        }
         else {
            
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: dateStr!)
        dateFormatter.dateFormat = "dd MMM"
  
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd "
        let s1 = dateFormatter1.date(from: dateStr1!)
        dateFormatter1.dateFormat = "dd MMM"
    

        cell.DateLbl.text =  NSString(format:"%@ - %@", dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String
            
        
        }
        cell.PlaceLbl.numberOfLines = 0
        cell.PlaceLbl.lineBreakMode = .byWordWrapping
        
        cell.DateLbl.numberOfLines = 0
        cell.DateLbl.lineBreakMode = .byWordWrapping
        
        cell.View123.layer.shadowOffset = CGSize(width : 0.9, height: 0.9)
        cell.View123.layer.shadowColor = UIColor.gray.cgColor
        cell.View123.layer.shadowRadius = 4
        cell.View123.layer.cornerRadius = 4
        cell.View123.layer.shadowOpacity = 0.8
        cell.View123.layer.masksToBounds = false
        cell.View123.clipsToBounds = false
        
        
        cell.PlaceLbl.frame = CGRect(x: cell.PlaceLbl.frame.origin.x, y: cell.PlaceLbl.frame.origin.y  , width: cell.PlaceLbl.frame.width, height: cell.PlaceLbl.optimalHeight)
        
        cell.venueLbl.frame = CGRect(x: cell.venueLbl.frame.origin.x, y: cell.PlaceLbl.frame.origin.y + cell.PlaceLbl.frame.height + 10, width: cell.venueLbl.frame.width, height: cell.venueLbl.optimalHeight)
        
        cell.lineLbl.frame = CGRect(x: cell.lineLbl.frame.origin.x, y: cell.lineLbl.frame.origin.y , width: cell.lineLbl.frame.width, height: 0.5 )
        
        cell.InterestedBtn.addTarget(self, action: #selector(EventView.inquire(_:)), for: UIControlEvents.touchUpInside)
        
        cell.ShareBtn.addTarget(self, action: #selector(EventView.ShareEvent(_:)), for: UIControlEvents.touchUpInside)
        
        let  screenWidth = self.view.frame.size.width
        
        let screensize = Int (screenWidth)
        
        switch (screensize) {
        case 320: // iPhone 4 and iPhone 5
            
            cell.PlaceLbl.font = UIFont(name: "AvenirNextLTPro-Demi", size: 13)
            cell.venueLbl.font = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
            cell.DateLbl.font = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
           
             cell.venueLbl.frame = CGRect(x: cell.venueLbl.frame.origin.x, y: cell.PlaceLbl.frame.origin.y + cell.PlaceLbl.frame.height + 5, width: cell.venueLbl.frame.width, height: cell.venueLbl.optimalHeight)
            
            cell.BannerImage.frame = CGRect(x: cell.BannerImage.frame.origin.x, y: 2, width: cell.BannerImage.frame.width, height: cell.View123.frame.height/2)
            
            cell.DateLbl.frame = CGRect(x: cell.DateLbl.frame.origin.x, y: cell.BannerImage.frame.origin.y + cell.BannerImage.frame.height + 3 , width: cell.DateLbl.frame.width, height: cell.DateLbl.optimalHeight)
            
            cell.PlaceLbl.frame = CGRect(x: cell.PlaceLbl.frame.origin.x, y: cell.DateLbl.frame.origin.y + cell.DateLbl.frame.height + 5  , width: cell.PlaceLbl.frame.width, height: cell.PlaceLbl.optimalHeight)
            
            cell.venueLbl.frame = CGRect(x: cell.venueLbl.frame.origin.x, y: cell.PlaceLbl.frame.origin.y + cell.PlaceLbl.frame.height + 5, width: cell.venueLbl.frame.width, height: cell.venueLbl.optimalHeight)
            
            cell.lineLbl.frame = CGRect(x: cell.lineLbl.frame.origin.x, y: cell.lineLbl.frame.origin.y , width: cell.lineLbl.frame.width, height: 0.5 )
            
            
            cell.InterestedBtn.frame = CGRect(x: cell.InterestedBtn.frame.origin.x, y: cell.lineLbl.frame.origin.y + cell.lineLbl.frame.height + 1 , width: cell.InterestedBtn.frame.width, height: cell.View123.frame.height/8 )
            
            cell.ShareBtn.frame = CGRect(x: cell.ShareBtn.frame.origin.x, y: cell.lineLbl.frame.origin.y + cell.lineLbl.frame.height + 1 , width: cell.ShareBtn.frame.width, height: cell.View123.frame.height/8)
            
            cell.InterestedBtn.titleLabel?.font =  UIFont(name: "AvenirNextLTPro-Demi", size: 13)
            cell.ShareBtn.titleLabel?.font =  UIFont(name: "AvenirNextLTPro-Demi", size: 13)

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "next", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next"
        {
            
        let indexPath:IndexPath = (sender as? IndexPath)!
        let obj:SubEvent = segue.destination as! SubEvent
        obj.EventID = NSString(format: "%@", (self.Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_id") as! CVarArg) as String
        obj.indexID = indexPath

         let arrcount = Eventlist.count
        obj.indexcount = arrcount
        }
        else if segue.identifier == "newNext"
        {
           
            let obj:SubEvent = segue.destination as! SubEvent
            obj.EventID = EventPreID
        }
    }
    
    func flowLayout()
    {
        let flowlayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 0.0
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 0.0
        flowlayout.sectionInset.top = 5.0
        flowlayout.sectionInset.right = 0.0
        flowlayout.itemSize.width = ( CardCollection.frame.size.width )
        flowlayout.itemSize.height = ( CardCollection.frame.size.height/1.5  )
        self.CardCollection.collectionViewLayout = flowlayout
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return EventCityArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
            let cell:CityCell = CityTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! CityCell
            cell.CityName.text = EventCityArray.object(at: (indexPath as NSIndexPath).row) as? String
       let selcity = EventCityArray.object(at: (indexPath as NSIndexPath).row) as? String

        if (selectedCity.contains(selcity!)) {
            cell.CheckImage.image = UIImage(named: "blackcheckbox")
            
        }
        else
        {
        cell.CheckImage.image = UIImage(named: "square-3")
    }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          
            let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
            
            let cell = CityTable.cellForRow(at: index) as! CityCell
            cell.CheckImage.image = UIImage(named: "blackcheckbox")
        
        let select =  EventCityArray.object(at: (indexPath as NSIndexPath).row) as! String
        selectedCity.append(select)
        
        let predicate = NSPredicate(format: "event_city == %@", select)
       
        filtered = Eventlist1.filter {predicate.evaluate(with: $0)} as NSArray
        
        Eventlistfilter.append(contentsOf: filtered)
       
//            let product = self.filterArray[indexPath.section].categories?[indexPath.row]
//            let name = product?.category_name
//            
//            self.company = self.companyDetails.filter{ ($0.company_categories?.contains(name!))! }
//        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
      
            let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
            
            let cell = CityTable.cellForRow(at: index) as! CityCell
            cell.CheckImage.image = UIImage(named: "square-3")
       
        
        let select =  EventCityArray.object(at: (indexPath as NSIndexPath).row) as! String
   
        selectedCity = selectedCity.filter { $0 != select }
       
        
        let predicate = NSPredicate(format: "event_city != %@", select)
        
        Eventlistfilter = Eventlistfilter.filter {predicate.evaluate(with: $0)} 
        
       // Eventlistfilter.append(contentsOf: filtered)
        
//            let product = self.filterArray[indexPath.section].categories?[indexPath.row]
//            let name = product?.category_name
//
//            namefilter = namefilter.filter { $0 != name! }
//
//            self.company  = self.companyDetails.filter {$0.company_categories != name!}
//
        
    }

    
    @IBAction func cityBtnAction(_ sender: AnyObject)
    {
        CityView.isHidden = false
        CityTable.reloadData()
        
    }
    
    @IBAction func cancelcityBtnAction(_ sender: AnyObject)
    {
        CityView.isHidden = true
        CityTable.reloadData()
    }
    
    @objc func inquire(_ sender : UIButton)
    {
       
        let point = sender.convert(CGPoint.zero, to: self.CardCollection as UIView)
        let indexPath: IndexPath! = self.CardCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.CardCollection.cellForItem(at: index) as! CardCell
       let eventID = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_id") as! Int
     
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["event_id": String(describing: eventID) ]
       
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.2/event/interested", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                   
                    let json = data as! NSDictionary
                    
                    let message = json.object(forKey: "message") as! String
                    
                    if(message == "Interested added successfully")
                    {
                        let image = UIImage(named: "likefilled")
                        cell.InterestedBtn.setImage(image, for: .normal)
                        cell.InterestedBtn.setTitle("  Interested",for: .normal)

                    }
                    else if(message == "Interested removed successfully")
                    {
                        let image = UIImage(named: "like3")
                        cell.InterestedBtn.setImage(image, for: .normal)
                        cell.InterestedBtn.setTitle("  Interested",for: .normal)
                        
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
    
    
    @IBAction func selectallBtnAction(_ sender: AnyObject)
    {
        for i in 0..<self.EventCityArray.count {
        
        let indexPath = IndexPath(row: i, section: 0)
        let cell = self.CityTable.cellForRow(at: indexPath ) as! CityCell
        cell.CheckImage.image = UIImage(named: "blackcheckbox")
            
        let selcity = EventCityArray.object(at: (indexPath as NSIndexPath).row) as? String
            
            selectedCity.append(selcity!)
            
            let predicate = NSPredicate(format: "event_city == %@", selcity!)
            
            filtered = Eventlist1.filter {predicate.evaluate(with: $0)} as NSArray
            
            Eventlistfilter = Eventlist1 as Array
        }
    }
    @IBAction func deselectallBtnAction(_ sender: AnyObject)
    {
        for i in 0..<self.EventCityArray.count {
            
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.CityTable.cellForRow(at: indexPath ) as! CityCell
            cell.CheckImage.image = UIImage(named: "square-3")
        }
        selectedCity.removeAll()
       
         Eventlistfilter = Eventlist1 as Array
    }
    @IBAction func applyBtnAction(_ sender: AnyObject)
    {
        
        CityView.isHidden = true
        Eventlist = Eventlistfilter as NSArray
        CardCollection.reloadData()

    }
    
    
    @objc func ShareEvent(_ sender : UIButton)
    {
      
        let point = sender.convert(CGPoint.zero, to: self.CardCollection as UIView)
        let indexPath: IndexPath! = self.CardCollection.indexPathForItem(at: point)
    
        let eventID = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_id") as! Int
    
        let linkString =  NSString(format:"https://indiasupply.com/event/%@",String(eventID)) as String

        guard let link = URL(string: linkString) else { return }
        let components = DynamicLinkComponents(link: link, domain: EventView.DYNAMIC_LINK_DOMAIN)
        
         let bundleID = "com.actiknow.IndiaSupply"
            // iOS params
            let iOSParams = DynamicLinkIOSParameters(bundleID: bundleID)
            iOSParams.fallbackURL = URL.init(string:"https://itunes.apple.com/in/app/indiasupply-dental-app/id1322426712")
            iOSParams.appStoreID = "1322426712"
            components.iOSParameters = iOSParams
            
        
        
            let packageName = "com.indiasupply.isdental"
            // Android params
            let androidParams = DynamicLinkAndroidParameters(packageName: packageName)
            androidParams.fallbackURL =  URL.init(string:"https://play.google.com/store/apps/details?id=com.indiasupply.isdental")
            components.androidParameters = androidParams
        

        let dateStr1 = (Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_end_date") as? String
      
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd "
            let s1 = dateFormatter1.date(from: dateStr1!)
            dateFormatter1.dateFormat = "dd MMM"

            
        let socialParams = DynamicLinkSocialMetaTagParameters()
        socialParams.title = NSString(format:"%@",((Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_name") as? String)! ) as String
        socialParams.descriptionText = NSString(format:"%@ , %@ ", dateFormatter1.string(from: s1!), ((Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_city")) as! String) as String
        socialParams.imageURL = URL.init(string:(Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_image") as! String)
        components.socialMetaTagParameters = socialParams


        longLink = components.url

        
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .short
        components.options = options
        components.shorten { (shortURL, warnings, error) in
           
            if let error = error {
               
                return
            }
            self.shortLink = shortURL
           
            
            let msg = "Hi, Checkout this event \(String(describing: socialParams.title!)) on \(NSString(format:"%@ in %@ ", dateFormatter1.string(from: s1!), ((self.Eventlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "event_city")) as! String) as String). To view full details visit \(String(describing: self.shortLink!))"
            
            
            let sharedObjects:[AnyObject] = [msg as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.mail, UIActivityType.message]
            
            self.present(activityViewController, animated: true, completion: nil)
            
            
        }
        
    }
 func dynamicLink()
 {
    EventPreID = UserDefaults.standard.object(forKey: "EventPreID") as! String
//    print(EventPreID)
   // self.performSegue(withIdentifier: "newNext", sender: self)
    
    }
    
}

