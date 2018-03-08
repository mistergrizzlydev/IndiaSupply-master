//
//  Account.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/10/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class Account : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    /**
     - Object names should be in camelCase
     - Don't use names like View1, it should be like viewEnquiries
     */
     @IBOutlet  var View1: UIView!
     @IBOutlet  var View2: UIView!
     @IBOutlet  var View3: UIView!
    
      @IBOutlet var UserTable: UITableView!
     @IBOutlet var UserTable1: UITableView!

    @IBOutlet var Version: UILabel!
    
    @IBOutlet var NameLBL: UILabel!
    @IBOutlet var EmailLBL: UILabel!
    
    @IBOutlet var GoBack : UIButton!
    
    /** Use [] instead of NSArray
     */
     var Enquiries : NSArray  = []
     var Favourites : NSArray  = []
     var Offers : NSArray  = []
    
     var Faqs : String = ""
     var TermsOfUse : String = ""
     var PrivacyPolicy : String = ""
     var HelpSupport : String = ""
    
     var FinalWebString : String = ""
     var NameStr : String = ""
    
    @IBOutlet  var MainScrollView : UIScrollView!
    
    /**
     No need create a var if list if static, Use let instead
     */
    let list : NSArray  = ["My Favorites", "My Enquiries"]
    
    let list1 : NSArray  = ["Help & Support", "Terms of use", "Privacy policy"]
    
    let Imagelist : NSArray  = ["myfavorite", "myinquiries"]
    
    let Imagelist1 : NSArray  = ["faq", "termsofuse", "privacypolicy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoBack.backgroundColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
       
        let versionNumberString =
            Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                as! String
    
        Version.text = NSString(format:"App Version (%@)", versionNumberString) as String
        SharedManager.showHUD(viewController: self)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
       
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/account", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                    
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonAccount")
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonAccount") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    /**
                     Create object for enquiries, favourites etc
                     */
                     self.Enquiries = json.object(forKey: "enquiries") as! NSArray
                     self.Favourites = json.object(forKey: "favourites") as! NSArray
                     self.Offers = json.object(forKey: "offers") as! NSArray
                    
                    self.Faqs = json.object(forKey: "html_faqs") as! String
                    self.TermsOfUse = json.object(forKey: "html_terms_of_use") as! String
                    self.PrivacyPolicy = json.object(forKey: "html_privacy_policy") as! String
                    self.HelpSupport = json.object(forKey: "html_help_and_support") as! String
                    
                    self.NameLBL.text = json.object(forKey: "user_name") as? String
                    self.EmailLBL.text = NSString(format:"%@  •  %@", json.object(forKey: "user_mobile") as! CVarArg, json.object(forKey: "user_email") as! String) as String
                    
                 
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
               
                if (UserDefaults.standard.object(forKey: "JsonAccount") != nil){
                    if  let jsond = UserDefaults.standard.object(forKey: "JsonAccount") as? NSData
                        
                    {
                        let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond as Data) as! NSDictionary
                        
                        self.Enquiries = json.object(forKey: "enquiries") as! NSArray
                        self.Favourites = json.object(forKey: "favourites") as! NSArray
                        self.Offers = json.object(forKey: "offers") as! NSArray
                        
                        self.Faqs = json.object(forKey: "html_faqs") as! String
                        self.TermsOfUse = json.object(forKey: "html_terms_of_use") as! String
                        self.PrivacyPolicy = json.object(forKey: "html_privacy_policy") as! String
                        self.HelpSupport = json.object(forKey: "html_help_and_support") as! String
                        
                        self.NameLBL.text = json.object(forKey: "user_name") as? String
                        self.EmailLBL.text = NSString(format:"%@  •  %@", json.object(forKey: "user_mobile") as! CVarArg, json.object(forKey: "user_email") as! String) as String
                        
                        
                        SharedManager.dismissHUD(viewController: self)
                    }}
                break
                
            }
        }
        
        MainScrollView.autoresizesSubviews = true
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: View1.frame.size.height + View2.frame.size.height + View3.frame.size.height + UserTable.frame.size.height + UserTable1.frame.size.height  + Version.frame.size.height)
  
    }
    
    
    override func viewWillAppear(_ animated: Bool)
        
    {
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/account", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json1 = data as! NSDictionary
                    
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: json1), forKey: "JsonAccount")
                    
                    let jsond = UserDefaults.standard.object(forKey: "JsonAccount") as? NSData
                    
                    let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond! as Data) as! NSDictionary
                    
                    /**
                     Create object for enquiries, favourites etc
                     */
                    self.Enquiries = json.object(forKey: "enquiries") as! NSArray
                    self.Favourites = json.object(forKey: "favourites") as! NSArray
                    self.Offers = json.object(forKey: "offers") as! NSArray
                    
                    self.Faqs = json.object(forKey: "html_faqs") as! String
                    self.TermsOfUse = json.object(forKey: "html_terms_of_use") as! String
                    self.PrivacyPolicy = json.object(forKey: "html_privacy_policy") as! String
                    self.HelpSupport = json.object(forKey: "html_help_and_support") as! String
                    
                    self.NameLBL.text = json.object(forKey: "user_name") as? String
                    self.EmailLBL.text = NSString(format:"%@  •  %@", json.object(forKey: "user_mobile") as! CVarArg, json.object(forKey: "user_email") as! String) as String
                    
                    
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                if (UserDefaults.standard.object(forKey: "JsonAccount") != nil){
                    if  let jsond = UserDefaults.standard.object(forKey: "JsonAccount") as? NSData
                        
                    {
                        let  json = NSKeyedUnarchiver.unarchiveObject(with: jsond as Data) as! NSDictionary
                        
                        self.Enquiries = json.object(forKey: "enquiries") as! NSArray
                        self.Favourites = json.object(forKey: "favourites") as! NSArray
                        self.Offers = json.object(forKey: "offers") as! NSArray
                        
                        self.Faqs = json.object(forKey: "html_faqs") as! String
                        self.TermsOfUse = json.object(forKey: "html_terms_of_use") as! String
                        self.PrivacyPolicy = json.object(forKey: "html_privacy_policy") as! String
                        self.HelpSupport = json.object(forKey: "html_help_and_support") as! String
                        
                        self.NameLBL.text = json.object(forKey: "user_name") as? String
                        self.EmailLBL.text = NSString(format:"%@  •  %@", json.object(forKey: "user_mobile") as! CVarArg, json.object(forKey: "user_email") as! String) as String
                        
                        
                        SharedManager.dismissHUD(viewController: self)
                    }}
                break
                
            }
        }
        
    }
    override func viewDidLayoutSubviews(){
        UserTable.frame = CGRect(x: UserTable.frame.origin.x, y: UserTable.frame.origin.y, width: UserTable.frame.size.width, height: UserTable.contentSize.height)
        UserTable.reloadData()
        
        UserTable1.frame = CGRect(x: UserTable1.frame.origin.x, y: View3.frame.origin.y + View3.frame.size.height, width: UserTable1.frame.size.width, height: UserTable1.contentSize.height)
        UserTable1.reloadData()
        
        View3.frame = CGRect(x: View3.frame.origin.x, y: UserTable.frame.origin.y + UserTable.frame.size.height
            , width: View3.frame.size.width, height: View3.frame.size.height)
        
        Version.frame = CGRect(x: Version.frame.origin.x, y: UserTable1.frame.origin.y + UserTable1.frame.size.height 
            , width: Version.frame.size.width, height: Version.frame.size.height)
   
    self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: View1.frame.size.height + View2.frame.size.height + View3.frame.size.height + UserTable.frame.size.height + UserTable1.frame.size.height  + Version.frame.size.height + 15 )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == UserTable)
        {
        return list.count
        }
        else
        {
            return list1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == UserTable)
        {
        let cell:AccountCell = UserTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! AccountCell
        cell.ProName.text = list.object(at: (indexPath as NSIndexPath).row) as? String
        cell.ProImage.image = UIImage(named: (Imagelist.object(at: (indexPath as NSIndexPath).row) as! String))!
        return cell
        }
        else
        {
            let cell:AccountCell = UserTable1.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! AccountCell
            cell.ProName.text = list1.object(at: (indexPath as NSIndexPath).row) as? String
            cell.ProImage.image = UIImage(named: (Imagelist1.object(at: (indexPath as NSIndexPath).row) as! String))!
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (tableView == UserTable)
        {
            if (indexPath.row == 0)
            {
                NameStr = "My Favourite"
                
                self.performSegue(withIdentifier: "fav" , sender: self)
            }
//            else if (indexPath.row == 1)
//            {
//                NameStr = "My Offers"
//
//                self.performSegue(withIdentifier: "offer" , sender: self)
//            }

            else if (indexPath.row == 1)
            {
                NameStr = "My Inquiries"
                self.performSegue(withIdentifier: "inq" , sender: self)
            }

            
        }
        else
        {
        
            
            if((indexPath as NSIndexPath).row == 0)
            {
               
                
                self.FinalWebString = self.HelpSupport
                NameStr = "Help & Support"

                 self.performSegue(withIdentifier: "2" , sender: self)
                
            }
          
            else if((indexPath as NSIndexPath).row == 1)
            {
                self.FinalWebString = self.TermsOfUse
                NameStr = "Terms of use"

                 self.performSegue(withIdentifier: "2" , sender: self)
                
            }
            else if((indexPath as NSIndexPath).row == 2)
            {
                self.FinalWebString = self.PrivacyPolicy
                NameStr = "Privacy Policy"

                 self.performSegue(withIdentifier: "2" , sender: self)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "2"
        {
            
            let obj: FaqPage  = segue.destination as! FaqPage
            obj.webString =  self.FinalWebString as  String
              obj.NameString = NameStr
            
        }
        else if ( segue.identifier == "fav" )
        {
        
            let obj:FavoritesPage = segue.destination as! FavoritesPage
            obj.TableArray =  self.Favourites as  NSArray
            obj.NameString = NameStr
            
        }
        else if ( segue.identifier == "offer" )
        {
            
            let obj:OffersPage = segue.destination as! OffersPage
            obj.TableArray =  self.Offers as  NSArray
            obj.NameString = NameStr
            
        }
        else if ( segue.identifier == "inq" )
        {
            
            let obj:InquiriesPage = segue.destination as! InquiriesPage
            obj.TableArray =  self.Enquiries as  NSArray
            obj.NameString = NameStr
            
        }
    }
    
    @IBAction func gobackAction(_ sender : UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
        
}
