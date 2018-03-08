//
//  SubEvent1.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/4/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit


class SubEvent1: UIViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource{

    
       @IBOutlet var ScheduleTable: UITableView!
       @IBOutlet var DateTable: UICollectionView!
   
       @IBOutlet var lineLbl: UILabel!
    
       @IBOutlet var ViewBack: UIView!
    
       @IBOutlet var showBtn: UIButton!
       @IBOutlet var hideBtn: UIButton!
    
       var DateID: NSArray  = []
       var ScheduleID = [ [String: Any] ]()
    
       var EventSchedule : NSDictionary  = [:]
   
       var DateArray  = [ [String: Any] ]()
       var ScheduleArray  = [ [String: Any] ]()
    
       var CountArray : NSMutableArray =  []
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        DateArray = (EventSchedule["dates"]  as! NSArray) as! [[String : Any]]
        ScheduleArray = (EventSchedule["schedules"]  as! NSArray) as! [[String : Any]]
        
         let dtdi = DateArray[0]["date_id"] as! Int
        
        ScheduleID = ScheduleArray.filter { schedule in
            DateArray.contains(where: { _ in dtdi == schedule["schedule_date_id"] as! Int }
            )}
     
        
      //  DateTable.isHidden = true
        
        ScheduleTable.frame =  CGRect(x: 20, y:  ScheduleTable.frame.origin.y , width: self.view.frame.size.width - 40, height: ScheduleTable.frame.size.height )
        
    //    lineLbl.frame =  CGRect(x: 0, y:  ScheduleTable.frame.origin.y - 3, width: self.view.frame.size.width , height: 1 )
       
        DateTable.frame =  CGRect(x: 20, y:DateTable.frame.origin.y , width: self.view.frame.size.width - 40, height: DateTable.frame.size.height )
        
        hideBtn.isHidden = true
         showBtn.isHidden = true
}

@IBAction func BackBtnAction(_ sender: AnyObject)
{
    dismiss(animated: false, completion: nil)
}

    @IBAction func ShowBtnAction(_ sender: AnyObject)
    {
        hideBtn.isHidden = false
        showBtn.isHidden = true
        
        DateTable.isHidden = false
        
        ScheduleTable.frame =  CGRect(x: 20, y:  DateTable.frame.origin.y + DateTable.frame.size.height + lineLbl.frame.size.height + 5, width: self.view.frame.size.width - 40, height: ScheduleTable.frame.size.height )
        lineLbl.frame =  CGRect(x: 0, y:  ScheduleTable.frame.origin.y - 3, width: self.view.frame.size.width , height: 1 )
    }
    
    @IBAction func HideBtnAction(_ sender: AnyObject)
    {
        hideBtn.isHidden = true
        showBtn.isHidden = false
        
        DateTable.isHidden = true
        
       ScheduleTable.frame =  CGRect(x: 20, y:  ScheduleTable.frame.origin.y - DateTable.frame.size.height, width: self.view.frame.size.width - 40, height: ScheduleTable.frame.size.height )
        
        lineLbl.frame =  CGRect(x: 0, y:  ScheduleTable.frame.origin.y - 3, width: self.view.frame.size.width , height: 1 )
        
    }
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return ScheduleID.count
       
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
    let cell:SubEventCell1 = ScheduleTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! SubEventCell1

    cell.Desc.text = ScheduleID[indexPath.row]["schedule_description"] as? String
    
   
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    
    let dateStr = (ScheduleID[indexPath.row]["schedule_start_time"]  as! CVarArg as! String)
    
    let s = dateFormatter.date(from: dateStr)
    
    dateFormatter.dateFormat = "HH:mm"
    
    
    
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "HH:mm:ss"
    
    let dateStr1 = (ScheduleID[indexPath.row]["schedule_end_time"]  as! CVarArg as! String)
    
    let s1 = dateFormatter1.date(from: dateStr1)
    
    dateFormatter1.dateFormat = "HH:mm"
    
    
    cell.Title.text =  NSString(format:"%@ - %@", dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String
    
    cell.Place.text = ScheduleID[indexPath.row]["schedule_location"] as? String
 
   
    return cell
    
}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return DateArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = DateTable.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! DateCell
        let imageURL = DateArray[indexPath.row]["date_image"] as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.DateImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "date_image"))
      
        cell.DateLbl.text = DateArray[indexPath.row]["date_title"] as? String
        
        cell.BLbl.isHidden = true
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
      let dtdi = DateArray[indexPath.row]["date_id"] as! Int
       
     ScheduleID = ScheduleArray.filter { schedule in
            DateArray.contains(where: { _ in dtdi == schedule["schedule_date_id"] as! Int }
            )}

        ScheduleTable.reloadData()
       
       
    }
    
   
    
}
