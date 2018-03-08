//
//  OffersPage.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/13/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//


import UIKit
class OffersPage: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet var Table: UITableView!
    @IBOutlet var Name: UILabel!
    var NameString : String = ""
    
    var TableArray : NSArray  = []
    
    @IBOutlet  var novalue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = NameString
        
        if (TableArray.count == 0)
        {
            novalue.isHidden = false
        }
        else
        {
            novalue.isHidden = true
            
        }
        Table.frame =  CGRect(x: 20, y:Table.frame.origin.y, width: self.view.frame.size.width - 40, height: Table.frame.size.height )
        

    }
    
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableCellOffers = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! TableCellOffers
        
        
        cell.offername.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "offer_text") as? String
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateStr = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "offer_start") as? String
        
        let s = dateFormatter.date(from: dateStr!)
        
        dateFormatter.dateFormat = "dd"
        
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateStr1 = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "offer_expire") as? String
        
        let s1 = dateFormatter1.date(from: dateStr1!)
        
        dateFormatter1.dateFormat = "dd MMM"
        
         
        cell.startdate.text =  NSString(format:"%@ - %@", dateFormatter.string(from: s!), dateFormatter1.string(from: s1!)) as String

       
        let Type = (self.TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "offer_status")  as! Int
         
        if (Type == 1) {
            
            cell.status.text =  "CURRENT"
            
        }
            
        else if (Type == 2)  {
            
            cell.status.text = "UPCOMING"
            
        }
        else if (Type == 0)  {
            
            cell.status.text =  "EXPIRED"
            
        }
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
}


