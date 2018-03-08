//
//  Services.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/9/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class Services: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet  var NoInternetView : UIView!
    
    @IBOutlet  var View1: UIView!
    @IBOutlet  var EquipmentTable: UITableView!
    
    @IBOutlet  var novalue: UIView!
    
    @IBOutlet  var lbl1: UILabel!
    
    var list : NSArray  = ["MY PRODUCTS","ADD PRODUCTS","MY REQUESTS","ADD REQUEST"] 
    
    var list1 : NSArray  = ["myproduct","addproduct","myrequest","addrequest"]
    
    var Prolist : NSArray  = []
    var Reqlist : NSArray  = []

    var Brandlist : NSArray  = []
    var Categorylist : NSArray  = []

    @IBOutlet  var addproductbtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
          self.novalue.isHidden = true
          self.EquipmentTable.isHidden = true
        self.addproductbtn.backgroundColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
        
        self.EquipmentTable.frame = CGRect(x: 20, y: EquipmentTable.frame.origin.y, width: self.view.frame.width - 20, height: self.EquipmentTable.frame.height)

        SharedManager.showHUD(viewController: self)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
       
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/service", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                   
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonService")
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonService") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    
                    self.Prolist = json.object(forKey: "products") as! NSArray
                    if (self.Prolist.count == 0)
                    {
                        self.novalue.isHidden = false
                    }
                    else
                    {
                        self.novalue.isHidden = true
                        
                    }
                 //   self.Reqlist = json.object(forKey: "requests") as! NSArray
                    self.Brandlist = json.object(forKey: "brands") as! NSArray
                    self.Categorylist = json.object(forKey: "categories") as! NSArray
                    self.EquipmentTable.reloadData()
                    
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
               
                if (UserDefaults.standard.object(forKey: "JsonService") != nil){
                    if  let jsond = UserDefaults.standard.object(forKey: "JsonService") as? NSData
                        
                    {
                        let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond as Data) as! NSDictionary
                        
                        self.Prolist = json.object(forKey: "products") as! NSArray
                        self.Reqlist = json.object(forKey: "requests") as! NSArray
                        self.Brandlist = json.object(forKey: "brands") as! NSArray
                        self.Categorylist = json.object(forKey: "categories") as! NSArray
                        
                        
                        self.EquipmentTable.reloadData()
                        
                        
                        SharedManager.dismissHUD(viewController: self)
                    }}
                break
                
            }
        }
        
    //    CardCollection.frame =  CGRect(x: 0, y:View1.frame.origin.y + View1.frame.size.height + 10, width: self.view.frame.size.width , height: CardCollection.frame.size.height )
        
   //     self.flowLayout()
        
      
        lbl1.frame =  CGRect(x: -10, y:View1.frame.size.height - 2, width: self.view.frame.size.width + 20, height: 0.9)
    }

    @IBAction func ProductBtnAction(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "2" , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        let obj:AddProducts = segue.destination as! AddProducts
        obj.Brandlist = self.Brandlist
        obj.Categorylist =  self.Categorylist
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return self.Prolist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell:ServiceCell = EquipmentTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! ServiceCell
        
        let imageURL  =  (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_image")  as! String
        
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        
        cell.ProTitle.text = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_brand") as? String
        cell.desc.text = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_description") as? String
         //cell.date.text = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_created_at") as? String
        
        let rate = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_created_at") as! String
        if (rate == "")
        {
            cell.date.isHidden = true
          
        }
        else
        {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateStr1 = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_created_at") as! String
            
            let s1 = dateFormatter1.date(from: dateStr1)
            
            dateFormatter1.dateFormat = "dd-MM-yyyy"
            
            cell.date.text =  NSString(format:"%@", dateFormatter1.string(from: s1!)) as String
   
        }
        
        let rate1 = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_status") as! String
        if (rate1 == "")
        {
            cell.status.isHidden = true
            
        }
        else
        {
            cell.status.text = (self.Prolist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_status") as? String
             if (rate1 == "CLOSED")
             {
                cell.status.backgroundColor = .gray
             }
            else
             {}
        }
        cell.serviceReqBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.serviceReqBtn.titleLabel?.textAlignment = .center
        cell.serviceReqBtn.setTitle("Service Request", for: .normal)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  

}
