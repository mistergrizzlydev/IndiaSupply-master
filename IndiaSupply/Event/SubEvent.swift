//
//  SubEvent.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/4/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class SubEvent: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet  var EventName: UILabel!
    @IBOutlet  var EventSchedule: UILabel!
    
    var expandedRows = Set<Int>()
    var dictArray  = [[String: Any]]()
    
    var indexcount: Int = 0
    
    var indexID:IndexPath = []
    
    var EventID:String = ""
    
    var FloorPlan:String = ""
    
    var GeneralInfo:String = ""
    
    var Register:String = ""
    
    var SpeakerArray : NSArray  = []
    
    var ExhibitArray : NSArray  = []
    
    var ScheduleArray  : NSArray  = []
    
    var EventScheArray : NSDictionary  = [:]
    
    var venue:String = ""
    
    //    @IBOutlet  var loadView1: UIView!
    
    @IBOutlet  var eventImg: FLImageView!
    
    @IBOutlet  var View1: UIView!
    @IBOutlet  var TabCollection: UICollectionView!
    
    var Imagelist : NSArray  = ["schedule","speaker","exhibitor","floorplan","generalinfo", "registration"]
    
    var list : NSArray  = ["Event Schedule","Speakers","Exhibitors","Floor Plan","General Information", "Registration"]
    var JsonDict : NSDictionary = [:]
    
    @IBOutlet  var dateLbl: UILabel!
    
    @IBOutlet  var EventsTable: UITableView!
    @IBOutlet  var SpeakersTable: UITableView!
    @IBOutlet  var ExhibitersTable: UITableView!
    
    
    @IBOutlet  var EventView: UIView!
    @IBOutlet  var SpeakerView: UIView!
    @IBOutlet  var ExhibitorsView: UIView!
    @IBOutlet  var FloorView: UIView!
    @IBOutlet  var GeneralView: UIView!
    @IBOutlet  var RegView: UIView!
    
    @IBOutlet  var EventView1: UIView!
    @IBOutlet  var SpeakerView1: UIView!
    @IBOutlet  var ExhibitorsView1: UIView!
    @IBOutlet  var FloorView1: UIView!
    @IBOutlet  var GeneralView1: UIView!
    @IBOutlet  var RegView1: UIView!
    
    
    @IBOutlet  var EventOpenView: UIView!
    @IBOutlet  var SpeakerOpenView: UIView!
    @IBOutlet  var ExhibitorsOpenView: UIView!
    @IBOutlet  var FloorOpenView: UIView!
    @IBOutlet  var GeneralOpenView: UIView!
    @IBOutlet  var RegisterOpenView: UIView!
    
    @IBOutlet var GeneralInfoWeb: UIWebView!
    @IBOutlet var RegisterWeb: UIWebView!
    
    @IBOutlet var FloorPlanImage : FLImageView!
    
    @IBOutlet  var MainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventView.layer.borderWidth = 0.5
        EventView.layer.borderColor = UIColor.lightGray.cgColor
        
        SpeakerView.layer.borderWidth = 0.5
        SpeakerView.layer.borderColor = UIColor.lightGray.cgColor
        
        ExhibitorsView.layer.borderWidth = 0.5
        ExhibitorsView.layer.borderColor = UIColor.lightGray.cgColor
        
        FloorView.layer.borderWidth = 0.5
        FloorView.layer.borderColor = UIColor.lightGray.cgColor
        
        GeneralView.layer.borderWidth = 0.5
        GeneralView.layer.borderColor = UIColor.lightGray.cgColor
        
        RegView.layer.borderWidth = 0.5
        RegView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        EventView1.layer.borderWidth = 0.5
        EventView1.layer.borderColor = UIColor.lightGray.cgColor
        
        SpeakerView1.layer.borderWidth = 0.5
        SpeakerView1.layer.borderColor = UIColor.lightGray.cgColor
        
        ExhibitorsView1.layer.borderWidth = 0.5
        ExhibitorsView1.layer.borderColor = UIColor.lightGray.cgColor
        
        FloorView1.layer.borderWidth = 0.5
        FloorView1.layer.borderColor = UIColor.lightGray.cgColor
        
        GeneralView1.layer.borderWidth = 0.5
        GeneralView1.layer.borderColor = UIColor.lightGray.cgColor
        
        RegView1.layer.borderWidth = 0.5
        RegView1.layer.borderColor = UIColor.lightGray.cgColor
        
        
        EventOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        
        self.SpeakerView.isHidden = true
        self.SpeakerView1.isHidden = true
        
        self.EventView.isHidden = true
        self.EventView1.isHidden = true
        
        self.ExhibitorsView.isHidden = true
        self.ExhibitorsView1.isHidden = true
        
        self.FloorView.isHidden = true
        self.FloorView1.isHidden = true
        
        self.GeneralView.isHidden = true
        self.GeneralView1.isHidden = true
        
        self.RegView.isHidden = true
        self.RegView1.isHidden = true
        
        
        
        dictArray.reserveCapacity(indexcount)
        
        SharedManager.showHUD(viewController: self)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        let url1 = NSString(format: "http://34.210.142.70/isdental/api/v2.1.1/event/%@", EventID)
        
        let url = URL(string: url1 as String)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let JsonDict = data as! NSDictionary
                  
                    if let dict = (JsonDict as NSDictionary) as? [String:AnyObject]  {
                        
                        if( UserDefaults.standard.object(forKey: "dictArray")  == nil)
                        {
                            for i in 0..<self.indexcount {
                                
                                if (i == self.indexID.row)
                                {
                                    self.dictArray.insert(dict, at: i)
                                    
                                }
                                else
                                {
                                    
                                    let dicparam : [String : Any] = [
                                        
                                        "event_name": "",
                                        "event_image": "",
                                        "event_type": "",
                                        "event_website": "http://www.magica2k17.com/",
                                        "event_information": "",
                                        "event_registrations": "",
                                        "event_start_date": "",
                                        "event_end_date": "",
                                        "event_city": "",
                                        "event_venue": "",
                                        "event_latitude": "",
                                        "event_longitude": "",
                                        "event_floor_plan": "",
                                        "event_exhibitors": [],
                                        "event_speakers": [],
                                        ]
                                    self.dictArray.insert(dicparam, at: i)
                                }
                            }
                            
                            UserDefaults.standard.set(self.dictArray, forKey: "dictArray")
                            
                        }
                        else
                        {
                            self.dictArray = UserDefaults.standard.object(forKey: "dictArray") as! [[String : Any]]
                            
                            for i in 0..<self.indexcount {
                                
                                if (i == self.indexID.row)
                                {
                                    self.dictArray.insert(dict, at: i)
                                    
                                }
                                else
                                {
                                    let item = self.dictArray[i]["event_name"] as! String
                                    
                                    if (item == "")
                                    {
                                        
                                        let dicparam : [String : Any] = [
                                            
                                            "event_name": "",
                                            "event_image": "",
                                            "event_type": "",
                                            "event_website": "",
                                            "event_information": "",
                                            "event_registrations": "",
                                            "event_start_date": "",
                                            "event_end_date": "",
                                            "event_city": "",
                                            "event_venue": "",
                                            "event_latitude": "",
                                            "event_longitude": "",
                                            "event_floor_plan": "",
                                            "event_exhibitors": [],
                                            "event_speakers": [],
                                            ]
                                        self.dictArray.insert(dicparam, at: i)
                                        
                                    }
                                    else if (item != "")
                                    {
                                        
                                    }
                                }
                            }
                            
                            UserDefaults.standard.set(self.dictArray, forKey: "dictArray")
                            
                        }
                        
                        
                        self.FloorPlan = (dict["event_floor_plan"] as! NSString) as String
                        self.GeneralInfo = (dict["event_information"] as! NSString) as String
                        self.Register = (dict["event_registrations"] as! NSString) as String
                        self.SpeakerArray =  dict["event_speakers"]  as! NSArray
                        self.ExhibitArray =  dict["event_exhibitors"]  as! NSArray
                        self.EventScheArray =  dict["event_schedule"]  as! NSDictionary
                        self.ScheduleArray = self.EventScheArray.value(forKey: "schedules") as! NSArray
                        
                        
                        
                        let fileName2 = self.FloorPlan
                        let fileArray = fileName2.components(separatedBy: "/")
                        let lastPath = fileArray.last as! String
                        
                        
                        
                        self.EventName.text = (dict["event_name"] as! NSString) as String
                        self.venue = (dict["event_venue"] as! NSString) as String
                        
                        self.EventsTable.reloadData()
                        self.SpeakersTable.reloadData()
                        self.RegisterWeb.loadHTMLString(self.Register, baseURL: nil)
                        self.RegisterWeb.scrollView.bounces = false
                        
                        self.GeneralInfoWeb.loadHTMLString(self.GeneralInfo, baseURL: nil)
                        self.GeneralInfoWeb.scrollView.bounces = false
                        
                        let trimmedUrl2 = self.FloorPlan.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
                        self.FloorPlanImage.loadImage(at: URL(string: trimmedUrl2), placeholderImage: UIImage(named: "place"))
                        
                        
                        
                        let imageURL = (dict["event_image"] as! NSString) as String
                        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
                        self.eventImg.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
                        
                        self.EventSchedule.text =  (dict["event_venue"] as! NSString) as String
                        let dateStr = (dict["event_start_date"] as! NSString) as String
                        
                        let dateStr1 = (dict["event_end_date"] as! NSString) as String
                        
                        if (dateStr == dateStr1 )
                        {
                            let dateFormatter1 = DateFormatter()
                            dateFormatter1.dateFormat = "yyyy-MM-dd "
                            let s1 = dateFormatter1.date(from: dateStr1)
                            dateFormatter1.dateFormat = "dd MMM"
                            
                            
                            self.dateLbl.text =  NSString(format:"%@ , %@ ", dateFormatter1.string(from: s1!), (dict["event_city"] as! NSString) as String) as String
                            
                        }
                        else {
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let s = dateFormatter.date(from: dateStr)
                            dateFormatter.dateFormat = "dd MMM"
                            
                            let dateFormatter1 = DateFormatter()
                            dateFormatter1.dateFormat = "yyyy-MM-dd "
                            let s1 = dateFormatter1.date(from: dateStr1)
                            dateFormatter1.dateFormat = "dd MMM"
                            
                            
                            self.dateLbl.text =  NSString(format:"%@ - %@", dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String
                            
                            
                        }
                        
                        
                        self.dateLbl.frame = CGRect(x: self.dateLbl.frame.origin.x, y: self.eventImg.frame.origin.y + self.eventImg.frame.height + 10  , width: self.dateLbl.frame.width, height: self.dateLbl.optimalHeight)
                        
                        self.EventName.frame = CGRect(x: self.EventName.frame.origin.x, y: self.dateLbl.frame.origin.y + self.dateLbl.frame.height + 5   , width: self.EventName.frame.width, height: self.EventName.optimalHeight)
                        
                        self.EventSchedule.frame = CGRect(x: self.EventSchedule.frame.origin.x, y: self.EventName.frame.origin.y + self.EventName.frame.height + 5 , width: self.EventSchedule.frame.width, height: self.EventSchedule.optimalHeight)
                        
                        
                        if (self.ScheduleArray.count == 0) {
                            
                            self.EventView1.isHidden = true
                            self.EventView.isHidden = true
                            
                            
                            self.EventView1.frame.size.height = 0
                            self.EventView.frame.size.height = 0
                            
                            
                        }
                        else
                        {
                            self.EventView1.isHidden = false
                            self.EventView.isHidden = false
                            
                            self.EventView1.frame.size.height = 40
                            self.EventView.frame.size.height = 40
                            
                        }
                        
                        if (self.SpeakerArray.count == 0) {
                            
                            self.SpeakerView.isHidden = true
                            self.SpeakerView1.isHidden = true
                            
                            self.SpeakerView.frame.size.height = 0
                            self.SpeakerView1.frame.size.height = 0
                            
                        }
                        else
                        {
                            self.SpeakerView1.isHidden = false
                            self.SpeakerView.isHidden = false
                            
                            self.SpeakerView.frame.size.height = 40
                            self.SpeakerView1.frame.size.height = 40
                            
                            
                        }
                        
                        if(self.ExhibitArray.count == 0)
                        {
                            self.ExhibitorsView.isHidden = true
                            self.ExhibitorsView1.isHidden = true
                            
                            self.ExhibitorsView.frame.size.height = 0
                            self.ExhibitorsView1.frame.size.height = 0
                        }
                        else
                        {
                            self.ExhibitorsView.isHidden = false
                            self.ExhibitorsView1.isHidden = false
                            
                            self.ExhibitorsView.frame.size.height = 40
                            self.ExhibitorsView1.frame.size.height = 40
                            
                            
                        }
                        if(lastPath.isEmpty)
                        {
                            self.FloorView.isHidden = true
                            self.FloorView1.isHidden = true
                            
                            self.FloorView.frame.size.height = 0
                            self.FloorView1.frame.size.height = 0
                        }
                        else{
                            self.FloorView.isHidden = false
                            self.FloorView1.isHidden = false
                            
                            self.FloorView.frame.size.height = 40
                            self.FloorView1.frame.size.height = 40
                        }
                        
                        if(self.GeneralInfo.isEmpty)
                        {
                            self.GeneralView.isHidden = true
                            self.GeneralView1.isHidden = true
                            
                            self.GeneralView.frame.size.height = 0
                            self.GeneralView1.frame.size.height = 0
                        }
                        else{
                            self.GeneralView.isHidden = false
                            self.GeneralView1.isHidden = false
                            
                            self.GeneralView.frame.size.height = 40
                            self.GeneralView1.frame.size.height = 40
                        }
                        
                        if(self.Register.isEmpty)
                        {
                            
                            self.RegView.isHidden = true
                            self.RegView1.isHidden = true
                            
                            self.RegView.frame.size.height = 0
                            self.RegView1.frame.size.height = 0
                        }
                        else{
                            self.RegView.isHidden = false
                            self.RegView1.isHidden = false
                            
                            self.RegView.frame.size.height = 40
                            self.RegView1.frame.size.height = 40
                        }
                        
                        
                        
                        
                        self.EventView.frame = CGRect(x: self.EventView.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height + 10 , width: self.EventView.frame.width, height: self.EventView.frame.size.height )
                        
                        self.EventView1.frame = CGRect(x: self.EventView1.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height + 10  , width: self.EventView1.frame.width, height: self.EventView1.frame.size.height )
                        
                        
                        self.SpeakerView.frame = CGRect(x: self.SpeakerView.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height  , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
                        
                        self.SpeakerView1.frame = CGRect(x: self.SpeakerView1.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
                        
                        
                        
                        
                        self.ExhibitorsView.frame = CGRect(x: self.ExhibitorsView.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: self.ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
                        
                        self.ExhibitorsView1.frame = CGRect(x: self.ExhibitorsView1.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: self.ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
                        
                        self.FloorView.frame = CGRect(x: self.FloorView.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: self.FloorView.frame.width, height: self.FloorView.frame.size.height )
                        
                        self.FloorView1.frame = CGRect(x: self.FloorView1.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: self.FloorView1.frame.width, height: self.FloorView1.frame.size.height )
                        
                        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
                        
                        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
                        
                        
                        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
                        
                        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
                        
                        
                        SharedManager.dismissHUD(viewController: self)
                        
                    }
                    
                }
                break
                
            case .failure(_):
                
                SharedManager.dismissHUD(viewController: self)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert :UIAlertAction) in
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }))
                self.present(alert, animated: true, completion: nil)
                //
                //            if (UserDefaults.standard.object(forKey: "dictArray") == nil)
                //            {
                //                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                //                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert :UIAlertAction) in
                //
                //                    self.dismiss(animated: true, completion: nil)
                //
                //                }))
                //                self.present(alert, animated: true, completion: nil)
                //
                //            }
                //                 else
                //            {
                //            self.dictArray = UserDefaults.standard.object(forKey: "dictArray") as! [[String : AnyObject]]
                //
                //                 let indexSet: IndexSet = [self.indexID.row]
                //
                //                 let result = indexSet.map { self.dictArray[$0] } as [[String:AnyObject]]
                //
                //                 let item = result[0]["event_name"]  as! String
                //
                //                 if (item == "")
                //                 {
                //                    let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                //                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert :UIAlertAction) in
                //
                //                        self.dismiss(animated: true, completion: nil)
                //
                //                    }))
                //                    self.present(alert, animated: true, completion: nil)
                //
                //                 }
                //                 else
                //                 {
                //                 self.FloorPlan = (result[0]["event_floor_plan"] as! NSString) as String
                //                 self.GeneralInfo = (result[0]["event_information"] as! NSString) as String
                //                 self.Register = (result[0]["event_registrations"] as! NSString) as String
                //                 self.SpeakerArray =  result[0]["event_speakers"]  as! NSArray
                //                 self.ExhibitArray =  result[0]["event_exhibitors"]  as! NSArray
                //                 self.EventScheArray =  result[0]["event_schedule"]  as! NSDictionary
                //                 self.EventName.text = (result[0]["event_name"] as! NSString) as String
                //                 self.venue = (result[0]["event_venue"] as! NSString) as String
                //
                //                 if (self.venue == "")
                //                 {
                //                    let dateStr = (result[0]["event_start_date"] as! NSString) as String
                //
                //                    let dateStr1 = (result[0]["event_end_date"] as! NSString) as String
                //
                //                    if (dateStr == dateStr1 )
                //                    {
                //                        let dateFormatter1 = DateFormatter()
                //                        dateFormatter1.dateFormat = "yyyy-MM-dd "
                //                        let s1 = dateFormatter1.date(from: dateStr1)
                //                        dateFormatter1.dateFormat = "dd MMM"
                //
                //
                //                        self.EventSchedule.text =  NSString(format:"%@ , %@ ", dateFormatter1.string(from: s1!),  (result[0]["event_city"] as! NSString)) as String
                //
                //                    }
                //                    else {
                //
                //                        let dateFormatter = DateFormatter()
                //                        dateFormatter.dateFormat = "yyyy-MM-dd"
                //                        let s = dateFormatter.date(from: dateStr)
                //                        dateFormatter.dateFormat = "dd"
                //
                //
                //                        let dateFormatter1 = DateFormatter()
                //                        dateFormatter1.dateFormat = "yyyy-MM-dd "
                //                        let s1 = dateFormatter1.date(from: dateStr1)
                //                        dateFormatter1.dateFormat = "dd MMM"
                //
                //
                //                        self.EventSchedule.text =  NSString(format:"%@ - %@ , %@ ", dateFormatter.string(from: s!), dateFormatter1.string(from: s1!), (result[0]["event_city"] as! NSString)) as String
                //                    }
                //
                //                 }
                //                 else
                //                 {
                //                    self.EventSchedule.text = NSString(format:"%@ , %@ ", (result[0]["event_venue"] as! NSString), (result[0]["event_city"] as! NSString)) as String
                //
                //                 }
                //                 SharedManager.viewdismissHUD(viewController: self.loadView1)
                //
                //            self.TabCollection.reloadData()
                //                }
                //                }
                //
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + 100)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == SpeakersTable) {
            return SpeakerArray.count
        }
        else  if (tableView == ExhibitersTable) {
            return ExhibitArray.count
        }
        else
        {
            return ScheduleArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == SpeakersTable) {
            
            let cell:SpeakerCell = SpeakersTable.dequeueReusableCell(withIdentifier: "Cell") as! SpeakerCell
            
            cell.Title.text = (SpeakerArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "speaker_name") as? String
            
            
            return cell
        }
        else if (tableView == ExhibitersTable) {
            
            let cell:ExhibitersCell = ExhibitersTable.dequeueReusableCell(withIdentifier: "Cell") as! ExhibitersCell
            
            cell.Title.text = (ExhibitArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "exhibitor_name") as? String
            
            cell.Date.text = (ExhibitArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "exhibitor_description") as? String
            
            return cell
        }
        else
        {
            let cell:Events = EventsTable.dequeueReusableCell(withIdentifier: "Cell") as! Events
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            let dateStr = (self.ScheduleArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "schedule_start_time") as! String
            
            let s = dateFormatter.date(from: dateStr)
            
            dateFormatter.dateFormat = "HH:mm"
            
            
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm:ss"
            
            let dateStr1 = (self.ScheduleArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "schedule_end_time") as! String
            
            let s1 = dateFormatter1.date(from: dateStr1)
            
            dateFormatter1.dateFormat = "HH:mm"
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            let dateStr2 = (self.ScheduleArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "schedule_date") as! String
            let s2 = dateFormatter2.date(from: dateStr2)
            dateFormatter2.dateFormat = "dd MMM "
            
            
            if( dateStr1 == "00:00:00")
            {
                cell.Date.text =  NSString(format:"%@ %@ onwards",dateFormatter2.string(from: s2!), dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String
                
            }
            else
            {
                cell.Date.text =  NSString(format:"%@ (%@ - %@)",dateFormatter2.string(from: s2!), dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String
            }
            cell.Date.textColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
            
            cell.Title.text = (self.ScheduleArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey : "schedule_description") as? String
            
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func ShowScheduleBtnAction(_ sender: AnyObject)
    {

        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        
        EventView1.isHidden = true
        EventView.isHidden = false
        EventOpenView.isHidden = false
        
        if (self.SpeakerArray.count == 0) {}
            
        else
        {
            SpeakerView1.isHidden = false
            SpeakerView.isHidden = true
        }
        
        if(self.ExhibitArray.count == 0)
        {}
        else
        {
            ExhibitorsView1.isHidden = false
            ExhibitorsView.isHidden = true
        }
        
        let fileName2 = self.FloorPlan
        let fileArray = fileName2.components(separatedBy: "/")
        let lastPath = fileArray.last
        if(lastPath?.isEmpty)!
        {}
        else{
            
            FloorView1.isHidden = false
            FloorView.isHidden = true
            
        }
        
        if(self.Register.isEmpty)
        {}
        else{
            
            RegView1.isHidden = false
            RegView.isHidden = true
        }
        
        if(self.GeneralInfo.isEmpty)
        {}
        else{
            self.GeneralView.isHidden = true
            self.GeneralView1.isHidden = false
        }
        
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + CGFloat(50 * (ScheduleArray.count)) + 100)
        
        
        EventOpenView.frame = CGRect(x: EventOpenView.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height, width: EventOpenView.frame.width, height: CGFloat(50 * (ScheduleArray.count)) )
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: EventOpenView.frame.origin.y + self.EventOpenView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        SpeakerView1.frame = CGRect(x: SpeakerView1.frame.origin.x, y: EventOpenView.frame.origin.y + self.EventOpenView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        EventOpenView.isHidden = false
        
    }
    @IBAction func HideScheduleBtnAction(_ sender: AnyObject)
    {
        EventView1.isHidden = false
        EventView.isHidden = true
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        SpeakerView1.frame = CGRect(x: SpeakerView1.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
      
        
        close()
    }
    
    
    @IBAction func ShowSpeakersBtnAction(_ sender: AnyObject)
    {
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true

        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0


        SpeakerView1.isHidden = true
        SpeakerView.isHidden = false
        SpeakerOpenView.isHidden = false

        if (self.ScheduleArray.count == 0) {}
            
        else
        {
            EventView1.isHidden = false
            EventView.isHidden = true
        }
        
        if(self.ExhibitArray.count == 0)
        {}
        else
        {
            ExhibitorsView1.isHidden = false
            ExhibitorsView.isHidden = true
        }
        
        let fileName2 = self.FloorPlan
        let fileArray = fileName2.components(separatedBy: "/")
        let lastPath = fileArray.last
        if(lastPath?.isEmpty)!
        {}
        else{
            
            FloorView1.isHidden = false
            FloorView.isHidden = true
            
        }
       
        if(self.Register.isEmpty)
        {}
        else{
            
            RegView1.isHidden = false
            RegView.isHidden = true
        }
        
        if(self.GeneralInfo.isEmpty)
        {}
        else{
            self.GeneralView.isHidden = true
            self.GeneralView1.isHidden = false
        }

        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + self.SpeakersTable.contentSize.height + 100)


        SpeakerOpenView.frame = CGRect(x: SpeakerOpenView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height, width: SpeakerOpenView.frame.width, height: CGFloat(40 * (SpeakerArray.count)) )


        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerOpenView.frame.origin.y + self.SpeakerOpenView.frame.size.height  , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )

        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerOpenView.frame.origin.y + self.SpeakerOpenView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )

        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )

        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )

        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )

        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )


        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )

        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )


    }
    @IBAction func HideSpeakersBtnAction(_ sender: AnyObject)
    {
     
        SpeakerView1.isHidden = false
        SpeakerView.isHidden = true

        
        SpeakerOpenView.isHidden = true
        SpeakerOpenView.frame.size.height = 0
        
        close()
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)

        
        self.EventView.frame = CGRect(x: self.EventView.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height , width: self.EventView.frame.width, height: self.EventView.frame.size.height )
        
        self.EventView1.frame = CGRect(x: self.EventView1.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height  , width: self.EventView1.frame.width, height: self.EventView1.frame.size.height )
        
        
        
        self.SpeakerView.frame = CGRect(x: self.SpeakerView.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        self.SpeakerView1.frame = CGRect(x: self.SpeakerView1.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        
        self.ExhibitorsView.frame = CGRect(x: self.ExhibitorsView.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: self.ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        self.ExhibitorsView1.frame = CGRect(x: self.ExhibitorsView1.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: self.ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        
        
        self.FloorView.frame = CGRect(x: self.FloorView.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: self.FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        self.FloorView1.frame = CGRect(x: self.FloorView1.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: self.FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
    }


    @IBAction func ShowExhiBtnAction(_ sender: AnyObject)
    {
        ExhibitorsView1.isHidden = true
        ExhibitorsView.isHidden = false
        ExhibitorsOpenView.isHidden = false
        
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        EventOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        
        if (self.ScheduleArray.count == 0) {}
        else
        {
            EventView1.isHidden = false
            EventView.isHidden = true
        }
        
        if(self.SpeakerArray.count == 0)
        {}
        else
        {
            SpeakerView1.isHidden = false
            SpeakerView.isHidden = true
        }
        
        let fileName2 = self.FloorPlan
        let fileArray = fileName2.components(separatedBy: "/")
        let lastPath = fileArray.last
        if(lastPath?.isEmpty)!
        {}
        else{
            
            FloorView1.isHidden = false
            FloorView.isHidden = true
            
        }
        
        if(self.Register.isEmpty)
        {}
        else{
            
            RegView1.isHidden = false
            RegView.isHidden = true
        }
        
        if(self.GeneralInfo.isEmpty)
        {}
        else{
            self.GeneralView.isHidden = true
            self.GeneralView1.isHidden = false
        }
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + self.ExhibitersTable.contentSize.height + 100)
        
        
        ExhibitorsOpenView.frame = CGRect(x: ExhibitorsOpenView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height, width: ExhibitorsOpenView.frame.width, height: CGFloat(40 * (ExhibitArray.count)) )
        
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsOpenView.frame.origin.y + self.ExhibitorsOpenView.frame.size.height , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )

    }
    @IBAction func HideExhiBtnAction(_ sender: AnyObject)
    {


        ExhibitorsView1.isHidden = false
        ExhibitorsView.isHidden = true

        
        ExhibitorsOpenView.isHidden = true
        ExhibitorsOpenView.frame.size.height = 0
        
        close()
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)
        

    }


    @IBAction func ShowFloorBtnAction(_ sender: AnyObject)
    {
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        FloorOpenView.frame.size.height = 265
        
        
        FloorView1.isHidden = true
        FloorView.isHidden = false
        FloorOpenView.isHidden = false
        
        ExhibitorsOpenView.isHidden = false
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        EventOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        
        ExhibitorsOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        
        if (self.ScheduleArray.count == 0) {}
        else
        {
            EventView1.isHidden = false
            EventView.isHidden = true
        }
        
        if(self.SpeakerArray.count == 0)
        {}
        else
        {
            SpeakerView1.isHidden = false
            SpeakerView.isHidden = true
        }
        
        if(self.ExhibitArray.count == 0)
        {}
        else
        {
            ExhibitorsView1.isHidden = false
            ExhibitorsView.isHidden = true
        }
        
        if(self.Register.isEmpty)
        {}
        else{
            
            RegView1.isHidden = false
            RegView.isHidden = true
        }
        
        if(self.GeneralInfo.isEmpty)
        {}
        else{
            self.GeneralView.isHidden = true
            self.GeneralView1.isHidden = false
        }
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + self.FloorOpenView.frame.height + 100)
        
        
        /*SpeakerOpenView.frame = CGRect(x: SpeakerOpenView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height, width: SpeakerOpenView.frame.width, height: CGFloat(40 * (SpeakerArray.count)) )*/
        
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: SpeakerView.frame.width, height: self.SpeakerView.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorOpenView.frame = CGRect(x: FloorOpenView.frame.origin.x, y: FloorView.frame.origin.y + self.FloorView.frame.size.height, width: FloorOpenView.frame.width, height: FloorOpenView.frame.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorOpenView.frame.origin.y + self.FloorOpenView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorOpenView.frame.origin.y + self.FloorOpenView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        FloorOpenView.isHidden = false
        
        
    }
    @IBAction func HideFloorBtnAction(_ sender: AnyObject)
    {
        /*FloorOpenView.isHidden = true
         GeneralOpenView.isHidden = true
         RegisterOpenView.isHidden = true
         SpeakerOpenView.isHidden = true
         EventOpenView.isHidden = true
         ExhibitorsOpenView.isHidden = true*/
        
        FloorView1.isHidden = false
        FloorView.isHidden = true
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        SpeakerView1.frame = CGRect(x: SpeakerView1.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        close()
        
    }
    
    @IBAction func ShowGeneralBtnAction(_ sender: AnyObject)
    {
        close()
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = false
        RegisterOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        GeneralOpenView.frame.size.height = 100
        
        
        GeneralView1.isHidden = true
        GeneralView.isHidden = false
        
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + self.GeneralOpenView.frame.height + 100)
        
        
        /*SpeakerOpenView.frame = CGRect(x: SpeakerOpenView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height, width: SpeakerOpenView.frame.width, height: CGFloat(40 * (SpeakerArray.count)) )*/
        
        
        
        
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralOpenView.frame = CGRect(x: self.GeneralOpenView.frame.origin.x, y: self.GeneralView.frame.origin.y + self.GeneralView.frame.size.height  , width: self.GeneralOpenView.frame.width, height: self.GeneralOpenView.frame.size.height )
        
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralOpenView.frame.origin.y + self.GeneralOpenView.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralOpenView.frame.origin.y + self.GeneralOpenView.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        GeneralOpenView.isHidden = false
        
        
        
    }
    @IBAction func HideGeneralBtnAction(_ sender: AnyObject)
    {
        
        
        GeneralView1.isHidden = false
        GeneralView.isHidden = true
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        SpeakerView1.frame = CGRect(x: SpeakerView1.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        close()
        
    }
    
    @IBAction func ShowRegBtnAction(_ sender: AnyObject)
    {
        close()
        
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = false
        SpeakerOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        RegisterOpenView.frame.size.height = 100
        
        
        RegView1.isHidden = true
        RegView.isHidden = false
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height + self.GeneralOpenView.frame.height + 100)
        
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        self.RegisterOpenView.frame = CGRect(x: self.RegisterOpenView.frame.origin.x, y: self.RegView.frame.origin.y + self.RegView.frame.size.height  , width: self.RegisterOpenView.frame.width, height: self.RegisterOpenView.frame.size.height )
        
        
        RegisterOpenView.isHidden = false
        
        
        
    }
    @IBAction func HideRegBtnAction(_ sender: AnyObject)
    {
        RegView1.isHidden = false
        RegView.isHidden = true
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: eventImg.frame.size.height + self.EventName.frame.size.height + self.EventSchedule.frame.size.height + self.dateLbl.frame.size.height + self.EventView.frame.size.height + self.SpeakerView.frame.size.height + self.ExhibitorsView.frame.size.height + self.FloorView.frame.size.height + self.GeneralView.frame.size.height + self.RegView.frame.size.height +  100)
        
        
        SpeakerView.frame = CGRect(x: SpeakerView.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        SpeakerView1.frame = CGRect(x: SpeakerView1.frame.origin.x, y: EventView.frame.origin.y + self.EventView.frame.size.height  , width: SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        ExhibitorsView.frame = CGRect(x: ExhibitorsView.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        ExhibitorsView1.frame = CGRect(x: ExhibitorsView1.frame.origin.x, y: SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        FloorView.frame = CGRect(x: FloorView.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        FloorView1.frame = CGRect(x: FloorView1.frame.origin.x, y: ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height  , width: FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height  , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        FloorOpenView.isHidden = true
        GeneralOpenView.isHidden = true
        RegisterOpenView.isHidden = true
        SpeakerOpenView.isHidden = true
        EventOpenView.isHidden = true
        ExhibitorsOpenView.isHidden = true
        
        FloorOpenView.frame.size.height = 0
        GeneralOpenView.frame.size.height = 0
        SpeakerOpenView.frame.size.height = 0
        ExhibitorsOpenView.frame.size.height = 0
        RegisterOpenView.frame.size.height = 0
        EventOpenView.frame.size.height = 0
        
        close()
        
    }
    
    func close()
    {
        
        
        self.EventView.frame = CGRect(x: self.EventView.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height + 10, width: self.EventView.frame.width, height: self.EventView.frame.size.height )
        
        self.EventView1.frame = CGRect(x: self.EventView1.frame.origin.x, y: self.EventSchedule.frame.origin.y + self.EventSchedule.frame.size.height + 10 , width: self.EventView1.frame.width, height: self.EventView1.frame.size.height )
        
        
        self.SpeakerView.frame = CGRect(x: self.SpeakerView.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height  , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        self.SpeakerView1.frame = CGRect(x: self.SpeakerView1.frame.origin.x, y: self.EventView1.frame.origin.y + self.EventView1.frame.size.height  , width: self.SpeakerView1.frame.width, height: self.SpeakerView1.frame.size.height )
        
        
        
        
        self.ExhibitorsView.frame = CGRect(x: self.ExhibitorsView.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: self.ExhibitorsView.frame.width, height: self.ExhibitorsView.frame.size.height )
        
        self.ExhibitorsView1.frame = CGRect(x: self.ExhibitorsView1.frame.origin.x, y: self.SpeakerView.frame.origin.y + self.SpeakerView.frame.size.height  , width: self.ExhibitorsView1.frame.width, height: self.ExhibitorsView1.frame.size.height )
        
        self.FloorView.frame = CGRect(x: self.FloorView.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: self.FloorView.frame.width, height: self.FloorView.frame.size.height )
        
        self.FloorView1.frame = CGRect(x: self.FloorView1.frame.origin.x, y: self.ExhibitorsView.frame.origin.y + self.ExhibitorsView.frame.size.height , width: self.FloorView1.frame.width, height: self.FloorView1.frame.size.height )
        
        self.GeneralView.frame = CGRect(x: self.GeneralView.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height  , width: self.GeneralView.frame.width, height: self.GeneralView.frame.size.height )
        
        self.GeneralView1.frame = CGRect(x: self.GeneralView1.frame.origin.x, y: self.FloorView.frame.origin.y + self.FloorView.frame.size.height , width: self.GeneralView1.frame.width, height: self.GeneralView1.frame.size.height )
        
        
        self.RegView.frame = CGRect(x: self.RegView.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height, width: self.RegView.frame.width, height: self.RegView.frame.size.height )
        
        self.RegView1.frame = CGRect(x: self.RegView1.frame.origin.x, y: self.GeneralView1.frame.origin.y + self.GeneralView1.frame.size.height , width: self.RegView1.frame.width, height: self.RegView1.frame.size.height )
        
        
        
        if (self.ScheduleArray.count == 0) {
            
            self.EventView1.isHidden = true
            self.EventView.isHidden = true
            
            
            self.EventView1.frame.size.height = 0
            self.EventView.frame.size.height = 0
            
            
        }
        else
        {
            self.EventView1.isHidden = false
            self.EventView.isHidden = false
            
            self.EventView1.frame.size.height = 40
            self.EventView.frame.size.height = 40
            
        }
        
        if (self.SpeakerArray.count == 0) {
            
            self.SpeakerView.isHidden = true
            self.SpeakerView1.isHidden = true
            
            self.SpeakerView.frame.size.height = 0
            self.SpeakerView1.frame.size.height = 0
            
        }
        else
        {
            self.SpeakerView1.isHidden = false
            self.SpeakerView.isHidden = false
            
            self.SpeakerView.frame.size.height = 40
            self.SpeakerView1.frame.size.height = 40
            
            
        }
        
        if(self.ExhibitArray.count == 0)
        {
            self.ExhibitorsView.isHidden = true
            self.ExhibitorsView1.isHidden = true
            
            self.ExhibitorsView.frame.size.height = 0
            self.ExhibitorsView1.frame.size.height = 0
        }
        else
        {
            self.ExhibitorsView.isHidden = false
            self.ExhibitorsView1.isHidden = false
            
            self.ExhibitorsView.frame.size.height = 40
            self.ExhibitorsView1.frame.size.height = 40
            
            
        }
        let fileName2 = self.FloorPlan
        let fileArray = fileName2.components(separatedBy: "/")
        let lastPath = fileArray.last
        
        if(lastPath?.isEmpty)!
        {
            self.FloorView.isHidden = true
            self.FloorView1.isHidden = true
            
            self.FloorView.frame.size.height = 0
            self.FloorView1.frame.size.height = 0
        }
        else{
            self.FloorView.isHidden = false
            self.FloorView1.isHidden = false
            
            self.FloorView.frame.size.height = 40
            self.FloorView1.frame.size.height = 40
        }
        
        if(self.GeneralInfo.isEmpty)
        {
            self.GeneralView.isHidden = true
            self.GeneralView1.isHidden = true
            
            self.GeneralView.frame.size.height = 0
            self.GeneralView1.frame.size.height = 0
        }
        else{
            self.GeneralView.isHidden = false
            self.GeneralView1.isHidden = false
            
            self.GeneralView.frame.size.height = 40
            self.GeneralView1.frame.size.height = 40
        }
        
        if(self.Register.isEmpty)
        {
            
            self.RegView.isHidden = true
            self.RegView1.isHidden = true
            
            self.RegView.frame.size.height = 0
            self.RegView1.frame.size.height = 0
        }
        else{
            self.RegView.isHidden = false
            self.RegView1.isHidden = false
            
            self.RegView.frame.size.height = 40
            self.RegView1.frame.size.height = 40
        }
    }

}

