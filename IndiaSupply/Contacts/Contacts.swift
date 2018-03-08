//
//  Exhibiters.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/3/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class Contacts : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchBarDelegate {
    
    @IBOutlet  var View1: UIView!
    
    @IBOutlet var SearchView: UIView!
    @IBOutlet  var SearchBtn: UIButton!
    @IBOutlet  var SearchBar: UISearchBar!
    @IBOutlet  var LineLbl: UILabel!
    @IBOutlet var SearchtableView: UIView!
     @IBOutlet  var filterfBtn: UIButton!
    
    @IBOutlet  var MainScrollView: UIScrollView!
    @IBOutlet  var MainScrollView1: UIScrollView!
    
    @IBOutlet  var lbl1: UILabel!
    
     var namefilter  = [String]()
    
     var companies : NSArray  = []

    var company: [companiesDetail] = []
    var company1: [companiesDetail] = []

    var company_categories : NSArray  = []

     var company_description : NSArray  = []
     var company_email : NSArray  = []
     var company_image : NSArray  = []
     var company_name : NSArray  = []
     var company_website : NSArray  = []
     var company_id : NSArray  = []
     var company_contacts : NSArray  = []
    
    var filterArray: [FilterArray] = []
    
    var EquipmentArray : NSArray  = []
    var MaterialsArray : NSArray  = []
    var MoreArray : NSArray  = []
    var group_name : NSArray  = []
    
    @IBOutlet  var NoInternetView : UIView!
    
    @IBOutlet  var filterview: UIView!
    
    @IBOutlet  var Table: UITableView!
    @IBOutlet  var Table1: UITableView!
   
    var companyDetails: [companiesDetail] = []
    
   @IBOutlet  var filterBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.NoInternetView.isHidden = true
         filterBtn.backgroundColor = UIColor(red: 44 / 255 , green: 152 / 255, blue: 165 / 255, alpha:1)
        
        self.SearchBtn.isEnabled = true
        self.filterfBtn.isEnabled = true
        
        self.Table1.allowsMultipleSelection = true
        MainScrollView.autoresizesSubviews = true
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.Table1.contentSize.height   )
        
        MainScrollView1.autoresizesSubviews = true
        self.MainScrollView1.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.Table.contentSize.height   )
        self.filterview.isHidden = true
        SearchBar.delegate = self
        
        SharedManager.showHUD(viewController: self)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
    
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/companies", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseObject  { (response:DataResponse<ContactRealm>) in
            
            switch(response.result) {
            case .success(_):
                let ContactsRes = response.result.value
                
                 self.NoInternetView.isHidden = true
                
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: (ContactsRes?.companies)!)
                UserDefaults.standard.set(encodedData, forKey: "companyDetailsArray")
                
                let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: (ContactsRes?.companies)!)
                UserDefaults.standard.set(encodedData1, forKey: "companybArray")
                
            
                
                self.companyDetails = (ContactsRes?.companies)!
                
                self.company = (ContactsRes?.companies)!
                self.company1 = (ContactsRes?.companies)!
                
                if let filterOfarray = ContactsRes?.filters{
                    
                    self.filterArray = filterOfarray.filter{$0.group_name != ""}
                  
                    let encodedDatafilter = NSKeyedArchiver.archivedData(withRootObject: (ContactsRes?.filters)!)
                    UserDefaults.standard.set(encodedDatafilter, forKey: "filterArray")
                    
                    
                }
                
                self.SearchBtn.isEnabled = true
                self.filterfBtn.isEnabled = true
                
                
                self.Table.reloadData()
                self.Table1.reloadData()
                self.updateContentHeight()
                SharedManager.dismissHUD(viewController: self)
                
            
                break
                
            case .failure(_):
                 SharedManager.dismissHUD(viewController: self)
                 self.NoInternetView.isHidden = false
                 
               

//                 let decoded = UserDefaults.standard.object(forKey: "companyDetailsArray") as? NSData
//                 let array = NSKeyedUnarchiver.unarchiveObject(with: decoded! as Data) as! [companiesDetail]
//
//                 let decoded1 = UserDefaults.standard.object(forKey: "companybArray") as? NSData
//
//                 self.companyDetails = array
//
//                 self.company = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companiesDetail]
//                 self.company1 = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companiesDetail]
//
//                 let decodedfilter = UserDefaults.standard.object(forKey: "filterArray") as? NSData
//
//
//                 self.filterArray = NSKeyedUnarchiver.unarchiveObject(with: decodedfilter! as Data) as! [FilterArray]
//
//
//                 self.SearchBtn.isEnabled = true
//                 self.filterfBtn.isEnabled = true
//
//
//                 self.Table.reloadData()
//                 self.Table1.reloadData()
//                 self.updateContentHeight()
                 SharedManager.dismissHUD(viewController: self)
                 
                break
                
            }
        }
        
        
         SearchView.isHidden = true
        
        let frame = CGRect(x: 30, y: 5, width: 320, height: 40)
        SearchBar.backgroundImage = UIImage()
        SearchBar.frame = frame
        SearchView.addSubview(SearchBar)
        
        lbl1.frame =  CGRect(x: -10, y:View1.frame.size.height - 2, width: self.view.frame.size.width + 20, height: 0.9)
        
        self.Table.frame = CGRect(x: 10, y: Table.frame.origin.y, width: self.view.frame.width - 20 , height: Table.frame.size.height + 50)

        
    }
    
    override func viewWillAppear(_ animated: Bool)
        
    {
        self.NoInternetView.isHidden = true
        
        self.SearchBtn.isEnabled = true
        self.filterfBtn.isEnabled = true
        
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/companies", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseObject  { (response:DataResponse<ContactRealm>) in
            
            switch(response.result) {
            case .success(_):
                let ContactsRes = response.result.value
                
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: (ContactsRes?.companies)!)
                UserDefaults.standard.set(encodedData, forKey: "companyDetailsArray")
                
                let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: (ContactsRes?.companies)!)
                UserDefaults.standard.set(encodedData1, forKey: "companybArray")
                
                self.NoInternetView.isHidden = true
                
                self.companyDetails = (ContactsRes?.companies)!
                
                self.company = (ContactsRes?.companies)!
                self.company1 = (ContactsRes?.companies)!
                
                if let filterOfarray = ContactsRes?.filters{
                    
                    self.filterArray = filterOfarray.filter{$0.group_name != ""}
                    
                    let encodedDatafilter = NSKeyedArchiver.archivedData(withRootObject: self.filterArray)
                    UserDefaults.standard.set(encodedDatafilter, forKey: "filterArray")
                    
                }
                
                self.SearchBtn.isEnabled = true
                self.filterfBtn.isEnabled = true
                
                self.Table.reloadData()
                self.Table1.reloadData()
                self.updateContentHeight()
                SharedManager.dismissHUD(viewController: self)
                
                
                break
                
            case .failure(_):
                SharedManager.dismissHUD(viewController: self)
//                let decoded = UserDefaults.standard.object(forKey: "companyDetailsArray") as? NSData
//                let array = NSKeyedUnarchiver.unarchiveObject(with: decoded! as Data) as! [companiesDetail]
//
//                let decoded1 = UserDefaults.standard.object(forKey: "companybArray") as? NSData
//
//                self.companyDetails = array
//
//                self.company = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companiesDetail]
//                self.company1 = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companiesDetail]
//
//                let decodedfilter = UserDefaults.standard.object(forKey: "filterArray") as? NSData
//
//
//                self.filterArray = NSKeyedUnarchiver.unarchiveObject(with: decodedfilter! as Data) as! [FilterArray]
//
//
//                self.SearchBtn.isEnabled = true
//                self.filterfBtn.isEnabled = true
//
//
//                self.Table.reloadData()
//                self.Table1.reloadData()
//                self.updateContentHeight()
                
                self.NoInternetView.isHidden = false
                
                SharedManager.dismissHUD(viewController: self)
                break
                
            }
        }
        
        
    }
    func updateContentHeight(){
        

       self.Table1.frame = CGRect(x: self.Table1.frame.origin.x, y: self.Table1.frame.origin.y, width: self.Table1.frame.size.width, height: self.Table1.contentSize.height  + 50)
        
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: Table1.frame.size.height  )

        self.Table.frame = CGRect(x: self.Table.frame.origin.x, y: self.Table.frame.origin.y, width: self.Table.frame.size.width, height: self.Table.contentSize.height)
        
        self.MainScrollView1.contentSize = CGSize(width: UIScreen.main.bounds.width,height: Table.frame.size.height  )

    }
    
    @IBAction func CroBtnAction(_ sender: AnyObject)
    {
         self.filterview.isHidden = true
    }
    
    @IBAction func FilterBtnAction(_ sender: AnyObject)
    {
         self.filterview.isHidden = false
    }
    @IBAction func resetBtnAction(_ sender: AnyObject)
    {
        self.company = self.company1
        
        self.Table.reloadData()
        
        self.filterview.isHidden = true
    }
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        SearchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          self.MainScrollView1.contentOffset = CGPoint( x : 0, y : 0)
        if searchBar.text == ""
        {
            self.company = self.company1
            
            self.Table.reloadData()
            
        }
        let searchText = searchBar.text!
        self.AutoSearchResult(searchText)
    }
    
    func AutoSearchResult(_ searchKey:String)
    {
        if (searchKey == "")
        {
            self.company = self.company1
            
            self.Table.reloadData()
        }
        else{


            self.company = self.companyDetails.filter{ ($0.company_name?.contains(searchKey))! }
   
            self.Table.reloadData()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          self.MainScrollView1.contentOffset = CGPoint( x : 0, y : 0)
        self.SearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.showsCancelButton = false
        SearchBar.text = ""
        SearchBar.resignFirstResponder()
          self.MainScrollView1.contentOffset = CGPoint( x : 0, y : 0)
    }
    @IBAction func SearchBtnAction(_ sender: AnyObject)
    {
   
        SearchView.isHidden = false
    
    }
    
    @IBAction func Apply(_ sender: AnyObject)
    {
  
      //  self.company = self.companyDetails.filter{ !namefilter.contains($0.company_categories!) }
    
        self.Table.reloadData()
          self.filterview.isHidden = true
    }
    
 
    @IBAction func CrossBtnAction(_ sender: AnyObject)
    {
       
       SearchBar.resignFirstResponder()
        SearchView.isHidden = true
      
        self.company = self.companyDetails
       self.SearchBar.text = ""
        self.Table.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (tableView == Table)
        {
            
            return 1
        }
        else
        {
            return filterArray.count
    }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       if (tableView == Table)
       {
        
            return company.count
       }
      else
       {
       
        return filterArray[section].categories?.count ?? 0
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == Table)
        {
       
            let cell:ContactsTableCell = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! ContactsTableCell
            
            let product = self.company[indexPath.item]
            cell.product = product
            
        return cell
        
        }
        else 
        {
             let cell:FilterCell = Table1.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! FilterCell
           
            let product = self.filterArray[indexPath.section].categories?[indexPath.row]
            cell.product = product

            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == Table)
        {
        
            self.performSegue(withIdentifier: "next", sender: indexPath)
            
        }
        else if (tableView == Table1)
        {
          
            let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
            
             let cell = Table1.cellForRow(at: index) as! FilterCell
            cell.FilterBtn.image = UIImage(named: "checktick")
            //cell.FilterBtn.setImage(UIImage(named: "checktick"), for: .normal)
            
           let product = self.filterArray[indexPath.section].categories?[indexPath.row]
            let name = product?.category_name
   
            self.company = self.companyDetails.filter{ ($0.company_categories?.contains(name!))! }
        }
        
    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if (tableView == Table)
        {
            
        }
        else if (tableView == Table1)
        {
           
            let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
            
            let cell = Table1.cellForRow(at: index) as! FilterCell
            cell.FilterBtn.image = UIImage(named: "checkbox")
          //  cell.FilterBtn.setImage(UIImage(named: "checkbox"), for: .normal)
            
            let product = self.filterArray[indexPath.section].categories?[indexPath.row]
            let name = product?.category_name
            
            namefilter = namefilter.filter { $0 != name! }
          
            self.company  = self.companyDetails.filter {$0.company_categories != name!}
            
   
        }

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
      
        let headerView = Table1.dequeueReusableCell(withIdentifier: "headerCell")
        
        let label6 = headerView?.viewWithTag(100) as? UILabel
        label6?.frame = CGRect(x: 20 , y: 20, width: Table1.frame.size.width, height: 40)
        label6?.text = filterArray[section].group_name ?? ""
        
        
        let label7 = UILabel(frame:CGRect(x: 0 , y: 8, width: Table1.frame.size.width, height: 40))
        label7.backgroundColor = UIColor.white
        
        headerView?.addSubview(label7)
        headerView?.addSubview(label6!)
        
        
        return headerView
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (tableView == Table)
        {
            return 0
        }
        else
        { return 40
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     
        let indexPath:IndexPath = (sender as? IndexPath)!
        let cell = Table.cellForRow(at: indexPath) as! ContactsTableCell
        
        let obj:SubContacts = segue.destination as! SubContacts
        obj.CompDetailArray = cell.companiesdetailsarray as! [companycontacts]
        obj.TitleName = cell.BrandTitle.text!
 
    }
}
