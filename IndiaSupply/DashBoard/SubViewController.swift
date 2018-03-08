//
//  SubViewController.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/27/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class SubViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextViewDelegate{
    
    var indexID:IndexPath = []
    
    var CompID:String = ""
    
    var productID:String = ""
    var indexi: Int = 0
    var indexcount: Int = 0
    
    var point : CGPoint = CGPoint()
    @IBOutlet  var CatLbl: UILabel!
    @IBOutlet  var NameLbl: UILabel!
    @IBOutlet  var DescribeCollection: UICollectionView!
    @IBOutlet  var lbl: UILabel!
    @IBOutlet  var ScrollView: UIScrollView!
    @IBOutlet  var View4: UIView!
    @IBOutlet  var BackButton: UIButton!
    @IBOutlet  var HideButton: UIButton!
    @IBOutlet  var View1: UIView!
    @IBOutlet  var ItemCollection: UICollectionView!
    @IBOutlet  var OfferLbl: UILabel!
    @IBOutlet var ProTable: UITableView!
    @IBOutlet  var MainScrollView: UIScrollView!
    
    @IBOutlet  var CompNameLbl: UILabel!
    @IBOutlet  var CompDesc: UILabel!
    @IBOutlet  var RatingLbl: UILabel!
    @IBOutlet  var TotalRatingsLbl: UILabel!
    @IBOutlet  var ContactsLbl: UILabel!
    @IBOutlet  var Contactsbtn: UIButton!
    @IBOutlet  var conLbl: UILabel!
    @IBOutlet  var CompanyOfferLbl: UILabel!
    
    @IBOutlet  var DotView: UIView!
    @IBOutlet  var star: UIImageView!
    @IBOutlet  var RecLbl: UILabel!
    @IBOutlet  var ReccLbl: UILabel!
    
    @IBOutlet  var CommentView: UIView!
    @IBOutlet  var CancelBtn: UIButton!
    @IBOutlet  var SubmitBtn: UIButton!
    @IBOutlet  var Comment: UITextView!
    @IBOutlet  var CommentView1: UIView!
    @IBOutlet  var loadView1: UIView!
    
    var Imagelist : NSArray  = ["CASH-BACK-APP-BANNER", "GDC-APP-BANNER", "KETAC-MOLAR-APP-BANNER", "WDS-APP-BANNER-2", "KETAC-MOLAR-APP-BANNER", "WDS-APP-BANNER-2"]
   
    var collectionArray1: [[ProductArray]] = []
    
    var collectionArray: [ProductArray] = []
    var tableArray: [ProductTitle] = []
    var CompDetailArray1 : [companycontacts] = []
    var RecommendedProGroups : NSArray  = []
    var height : CGFloat!
    
    var dictArray  = [[String: Any]]()
    var dicparameter : [String : Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RatingLbl.isHidden = true
        TotalRatingsLbl.isHidden = true
        star.isHidden = true
        
        CommentView.isHidden = true
        self.flowLayout()
        View4.isHidden = true
        ScrollView.autoresizesSubviews = true
        MainScrollView.autoresizesSubviews = true
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: ItemCollection.frame.size.height + ProTable.frame.size.height + View1.frame.size.height + 170)
        self.ScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: DescribeCollection.frame.size.height )
       
        CommentView1.layer.borderWidth = 0.8
        CommentView1.layer.cornerRadius = 3
        CommentView1.layer.borderColor = UIColor.lightGray.cgColor
        
        Comment.layer.borderWidth = 0.5
        Comment.layer.cornerRadius = 3
        Comment.layer.borderColor = UIColor.lightGray.cgColor
        
        MainScrollView.delegate = self
        OfferLbl.layer.borderWidth = 0.8
        OfferLbl.layer.cornerRadius = 3
        OfferLbl.layer.borderColor = UIColor.lightGray.cgColor
        
        NameLbl.fadeOut()
        CatLbl.fadeOut()
        
       self.MainScrollView.isHidden = true
        SharedManager.ViewshowHUD(viewController: self.loadView1)
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
       
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        let url1 = NSString(format: "http://34.210.142.70/isdental/api/v2.1.1/company/%@", CompID)
        
        let url = URL(string: url1 as String)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseObject { (response: DataResponse<ProductGroup>) in
            
            switch(response.result) {
            case .success(_):
               
                if let ProductGroupRes = response.result.value{
                
                    self.CompNameLbl.numberOfLines = 0
                    self.CompNameLbl.lineBreakMode = .byWordWrapping
                    
                    self.CompNameLbl.text = ProductGroupRes.company_name
                    self.CompDesc.text =  ProductGroupRes.company_categories
                    self.RatingLbl.text =  ProductGroupRes.company_rating
                    self.CompDetailArray1 = ProductGroupRes.company_contacts!
                    let strrate = " \(ProductGroupRes.company_total_ratings ?? 0)"
                    self.TotalRatingsLbl.text = NSString(format:" %@ Ratings", strrate) as String
                    self.ContactsLbl.text = " \(ProductGroupRes.company_total_contacts ?? 0)"
                    
                    self.NameLbl.text =  ProductGroupRes.company_name
                    self.CatLbl.text =  ProductGroupRes.company_categories
                  
                    let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_name!)
                    UserDefaults.standard.set(encodedData1, forKey: "company_name")

                    let encodedData2 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_categories!)
                    UserDefaults.standard.set(encodedData2, forKey: "company_categories")

                    let encodedData3 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_rating!)
                    UserDefaults.standard.set(encodedData3, forKey: "company_rating")

                    let encodedData4 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_contacts!)
                    UserDefaults.standard.set(encodedData4, forKey: "company_contacts")

                    let encodedData5 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_total_ratings!)
                    UserDefaults.standard.set(encodedData5, forKey: "company_total_ratings")

                    let encodedData6 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_total_contacts!)
                    UserDefaults.standard.set(encodedData6, forKey: "company_total_contacts")

                          if let products = ProductGroupRes.products{
                  
                        self.collectionArray = products.filter{$0.group_type == 1}.first?.productsA ?? []
                        self.tableArray = products.filter{$0.group_type == 2}
                       
                            self.dicparameter = [
                                
                                "company_name": ProductGroupRes.company_name!,
                                "company_total_contacts": ProductGroupRes.company_total_contacts!,
                                "company_categories": ProductGroupRes.company_categories!,
                                "company_rating": ProductGroupRes.company_rating!,
                                "company_total_ratings": ProductGroupRes.company_total_ratings!,
                                "company_offers": ProductGroupRes.company_offers!,
                                "collectionArray": products.filter{$0.group_type == 1}.first?.productsA ?? [],
                                 "tableArray": products.filter{$0.group_type == 2},
                                 "company_contacts": ProductGroupRes.company_contacts!
                            ]
                        let encodedData7 = NSKeyedArchiver.archivedData(withRootObject: self.collectionArray)
                        UserDefaults.standard.set(encodedData7, forKey: "collectionArray")

                        let encodedData8 = NSKeyedArchiver.archivedData(withRootObject: self.tableArray)
                        UserDefaults.standard.set(encodedData8, forKey: "tableArray")

                    let decoded6 = UserDefaults.standard.object(forKey: "collectionArray1") as? NSData

                            if (decoded6?.length == nil)
                            {}
                            else
                            {

                            let decoded6 = UserDefaults.standard.object(forKey: "collectionArray1") as? NSData
                            self.collectionArray1 = NSKeyedUnarchiver.unarchiveObject(with: decoded6! as Data) as! [[ProductArray]]


                       self.collectionArray1.append(self.collectionArray)

                       // self.collectionArray1.remove(at: self.indexID.row)
                     //   self.collectionArray1.insert(self.collectionArray, at: self.indexID.row)
                            }
                        let encodedData10 = NSKeyedArchiver.archivedData(withRootObject: self.collectionArray1)
                        UserDefaults.standard.set(encodedData10, forKey: "collectionArray1")

    
                        self.ItemCollection.reloadData()
                       
                        self.DescribeCollection.reloadData()
                        self.ProTable.reloadData()
                        self.updateContentHeight()
                        self.MainScrollView.isHidden = false
                        SharedManager.viewdismissHUD(viewController: self.loadView1)
                    }
                   
                    let OfferString = ProductGroupRes.company_offers
                    
                    let encodedData9 = NSKeyedArchiver.archivedData(withRootObject: ProductGroupRes.company_offers!)
                    UserDefaults.standard.set(encodedData9, forKey: "company_offers")

                    if (OfferString == "")
                    {
                        self.CompanyOfferLbl.isHidden = true
                        self.View1.frame = CGRect(x: self.View1.frame.origin.x, y: self.View1.frame.origin.y, width: self.View1.frame.size.width, height: self.View1.frame.size.height - 10)
                        self.CompNameLbl.frame = CGRect(x: self.CompNameLbl.frame.origin.x + 10, y: 0, width: self.CompNameLbl.frame.size.width, height: 50)
                        self.CompDesc.frame = CGRect(x: self.CompDesc.frame.origin.x + 10, y: self.CompNameLbl.frame.origin.y + self.CompNameLbl.frame.size.height
                            , width: self.CompDesc.frame.size.width, height: 30)
                        self.DotView.frame = CGRect(x: self.DotView.frame.origin.x, y: self.CompDesc.frame.origin.y + self.CompDesc.frame.size.height + 15
                            , width: self.DotView.frame.size.width, height: self.DotView.frame.size.height)
                        self.star.frame = CGRect(x: self.star.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 18
                            , width: self.star.frame.size.width, height: self.star.frame.size.height)
                        self.RatingLbl.frame = CGRect(x: self.RatingLbl.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                            , width: self.RatingLbl.frame.size.width, height: self.RatingLbl.frame.size.height)
                        self.TotalRatingsLbl.frame = CGRect(x: self.TotalRatingsLbl.frame.origin.x, y: self.RatingLbl.frame.origin.y + self.RatingLbl.frame.size.height
                            , width: self.TotalRatingsLbl.frame.size.width, height: self.TotalRatingsLbl.frame.size.height)
                        self.ContactsLbl.frame = CGRect(x: self.ContactsLbl.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                            , width: self.ContactsLbl.frame.size.width, height: self.ContactsLbl.frame.size.height)
                        self.Contactsbtn.frame = CGRect(x: self.Contactsbtn.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                            , width: self.Contactsbtn.frame.size.width, height: self.Contactsbtn.frame.size.height)
                        self.conLbl.frame = CGRect(x: self.conLbl.frame.origin.x, y: self.ContactsLbl.frame.origin.y + self.ContactsLbl.frame.size.height
                            , width: self.conLbl.frame.size.width, height: self.conLbl.frame.size.height)
                        self.RecLbl.frame = CGRect(x: self.RecLbl.frame.origin.x, y: self.View1.frame.origin.y + self.View1.frame.size.height + 15 , width: self.RecLbl.frame.size.width, height: self.RecLbl.frame.size.height)
                        self.ReccLbl.frame = CGRect(x: self.ReccLbl.frame.origin.x, y: self.View1.frame.origin.y + self.View1.frame.size.height + 15 , width: self.ReccLbl.frame.size.width, height: self.ReccLbl.frame.size.height)
                      
                        self.ItemCollection.frame = CGRect(x: self.ItemCollection.frame.origin.x, y: self.ReccLbl.frame.origin.y + self.ReccLbl.frame.size.height , width: self.ItemCollection.frame.size.width, height: self.ItemCollection.frame.size.height)
                        
                    }
                    else {
                        self.CompanyOfferLbl.text = ProductGroupRes.company_offers
                    }
                   
                    
//
//                        if( UserDefaults.standard.object(forKey: "dictFeatureArray")  == nil)
//                        {
//                            for i in 0..<self.indexcount {
//
//                                if (i == self.indexID.row)
//                                {
//
//                                    self.dictArray.insert(self.dicparameter, at: i)
//
//                                }
//                                else
//                                {
//                                    let dicparam : [String : Any] = [
//
//                                        "company_name": "",
//                                        "company_total_contacts": "",
//                                        "company_categories": "",
//                                        "company_rating": "",
//                                        "company_total_ratings": "",
//                                        "company_offers": "",
//                                        "collectionArray": "",
//                                        "tableArray": "",
//                                        "company_contacts": ""
//                                    ]
//                                    self.dictArray.insert(dicparam, at: i)
//                                }
//                            }
//
//                            let encodedData9 = NSKeyedArchiver.archivedData(withRootObject: self.dictArray)
//                        UserDefaults.standard.set(encodedData9, forKey: "dictFeatureArray")
//
//                        }
//                        else
//                        {
//                            self.dictArray = UserDefaults.standard.object(forKey: "dictFeatureArray") as! [[String : Any]]
//
//                            for i in 0..<self.indexcount {
//
//                                if (i == self.indexID.row)
//                                {
//
//                                    self.dictArray.insert(self.dicparameter, at: i)
//
//                                }
//                                else
//                                {
//                                    let item = self.dictArray[i]["company_name"] as! String
//
//                                    if (item == "")
//                                    {
//
//                                        let dicparam : [String : Any] = [
//                                        "company_name": "",
//                                        "company_total_contacts": "",
//                                        "company_categories": "",
//                                        "company_rating": "",
//                                        "company_total_ratings": "",
//                                        "company_offers": "",
//                                        "collectionArray": "",
//                                        "tableArray": "",
//                                        "company_contacts": ""
//                                        ]
//                                        self.dictArray.insert(dicparam, at: i)
//
//                                    }
//                                    else if (item != "")
//                                    {
//
//                                    }
//                                }
//                            }
//
//                            let encodedData9 = NSKeyedArchiver.archivedData(withRootObject: self.dictArray)
//                            UserDefaults.standard.set(encodedData9, forKey: "dictFeatureArray")
//
//                        }
                    
                        
                }
                break
                    
              case .failure(_):
                 SharedManager.viewdismissHUD(viewController: self.loadView1)
                 
//                 if (UserDefaults.standard.object(forKey: "dictFeatureArray") == nil)
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
//                    let decoded1 = UserDefaults.standard.object(forKey: "dictFeatureArray") as? NSData
//
//                    self.dictArray = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [[String : Any]]
//
//                    let indexSet: IndexSet = [self.indexID.row]
//
//                    let result = indexSet.map { self.dictArray[$0] } as [[String:AnyObject]]
//
//                    let item = result[0]["company_name"]  as! String
//
//                    print(item)
//
//                    if (item == "")
//                    {
//                        let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
//                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(alert :UIAlertAction) in
//
//                            self.dismiss(animated: true, completion: nil)
//
//                        }))
//                        self.present(alert, animated: true, completion: nil)
//
//                    }
//                    else
//                    {
//
//                        self.CompNameLbl.text = (result[0]["company_name"] as! NSString) as String
//                        self.CompDesc.text = (result[0]["company_categories"] as! NSString) as String
//                        self.RatingLbl.text = (result[0]["company_rating"] as! NSString) as String
//                        self.CompDetailArray1 =  (result[0]["company_contacts"]  as! NSArray) as! [companycontacts]
//                        let strrate = " \(result[0]["company_total_ratings"] ?? 0 as AnyObject)"
//                        self.TotalRatingsLbl.text = NSString(format:" %@ Ratings", strrate) as String
//
//                        let strcont = " \(result[0]["company_total_contacts"] ?? 0 as AnyObject)"
//                        self.ContactsLbl.text = NSString(format:"%@", strcont) as String
//
//                        self.MainScrollView.isHidden = false
//
//
//                    }
//                 }
                 let decoded1 = UserDefaults.standard.object(forKey: "company_name") as? NSData
                 let company_name = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data)
                 self.CompNameLbl.text = company_name as? String
                 self.NameLbl.text = company_name as? String

                 self.MainScrollView.isHidden = false

                 let decoded2 = UserDefaults.standard.object(forKey: "company_categories") as? NSData
                 let company_categories = NSKeyedUnarchiver.unarchiveObject(with: decoded2! as Data)
                 self.CompDesc.text = company_categories as? String

                 let decoded3 = UserDefaults.standard.object(forKey: "company_rating") as? NSData
                 let company_rating = NSKeyedUnarchiver.unarchiveObject(with: decoded3! as Data)
                 self.RatingLbl.text  = company_rating as? String

                 let decoded4 = UserDefaults.standard.object(forKey: "company_contacts") as? NSData
                 let company_contacts = NSKeyedUnarchiver.unarchiveObject(with: decoded4! as Data)
                 self.CompDetailArray1  = company_contacts as! [companycontacts]

                 let decoded5 = UserDefaults.standard.object(forKey: "company_total_contacts") as? NSData
                 let company_total_contacts = NSKeyedUnarchiver.unarchiveObject(with: decoded5! as Data)
                 let strcon = company_total_contacts as! Int
                 self.ContactsLbl.text = String(strcon)

                 let decoded6 = UserDefaults.standard.object(forKey: "collectionArray1") as? NSData
                 self.collectionArray1 = NSKeyedUnarchiver.unarchiveObject(with: decoded6! as Data) as! [[ProductArray]]
                 let indexSet: IndexPath = [self.indexID.row]


              //   self.collectionArray = self.collectionArray1.localizedStandardContains(company_name)



                 let decoded7 = UserDefaults.standard.object(forKey: "tableArray") as? NSData
                 let tableAr = NSKeyedUnarchiver.unarchiveObject(with: decoded7! as Data) as! [ProductTitle]
                 self.tableArray = tableAr


                 self.ItemCollection.reloadData()

                 self.DescribeCollection.reloadData()
                 self.ProTable.reloadData()
                 self.updateContentHeight()
                 self.MainScrollView.isHidden = false


                 let decoded8 = UserDefaults.standard.object(forKey: "company_offers") as? NSData
                 let company_offers = NSKeyedUnarchiver.unarchiveObject(with: decoded8! as Data) as!String

                 let OfferString = company_offers

                 if (OfferString == "")
                 {
                    self.CompanyOfferLbl.isHidden = true
                    self.View1.frame = CGRect(x: self.View1.frame.origin.x, y: self.View1.frame.origin.y, width: self.View1.frame.size.width, height: self.View1.frame.size.height - 10)
                    self.CompNameLbl.frame = CGRect(x: self.CompNameLbl.frame.origin.x + 10, y: 0, width: self.CompNameLbl.frame.size.width, height: 50)
                    self.CompDesc.frame = CGRect(x: self.CompDesc.frame.origin.x + 10, y: self.CompNameLbl.frame.origin.y + self.CompNameLbl.frame.size.height
                        , width: self.CompDesc.frame.size.width, height: 30)
                    self.DotView.frame = CGRect(x: self.DotView.frame.origin.x, y: self.CompDesc.frame.origin.y + self.CompDesc.frame.size.height + 15
                        , width: self.DotView.frame.size.width, height: self.DotView.frame.size.height)
                    self.star.frame = CGRect(x: self.star.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 18
                        , width: self.star.frame.size.width, height: self.star.frame.size.height)
                    self.RatingLbl.frame = CGRect(x: self.RatingLbl.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                        , width: self.RatingLbl.frame.size.width, height: self.RatingLbl.frame.size.height)
                    self.TotalRatingsLbl.frame = CGRect(x: self.TotalRatingsLbl.frame.origin.x, y: self.RatingLbl.frame.origin.y + self.RatingLbl.frame.size.height
                        , width: self.TotalRatingsLbl.frame.size.width, height: self.TotalRatingsLbl.frame.size.height)
                    self.ContactsLbl.frame = CGRect(x: self.ContactsLbl.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                        , width: self.ContactsLbl.frame.size.width, height: self.ContactsLbl.frame.size.height)
                    self.Contactsbtn.frame = CGRect(x: self.Contactsbtn.frame.origin.x, y: self.DotView.frame.origin.y + self.DotView.frame.size.height + 15
                        , width: self.Contactsbtn.frame.size.width, height: self.Contactsbtn.frame.size.height)
                    self.conLbl.frame = CGRect(x: self.conLbl.frame.origin.x, y: self.ContactsLbl.frame.origin.y + self.ContactsLbl.frame.size.height
                        , width: self.conLbl.frame.size.width, height: self.conLbl.frame.size.height)
                    self.RecLbl.frame = CGRect(x: self.RecLbl.frame.origin.x, y: self.View1.frame.origin.y + self.View1.frame.size.height + 15 , width: self.RecLbl.frame.size.width, height: self.RecLbl.frame.size.height)
                    self.ReccLbl.frame = CGRect(x: self.ReccLbl.frame.origin.x, y: self.View1.frame.origin.y + self.View1.frame.size.height + 15 , width: self.ReccLbl.frame.size.width, height: self.ReccLbl.frame.size.height)

                    self.ItemCollection.frame = CGRect(x: self.ItemCollection.frame.origin.x, y: self.ReccLbl.frame.origin.y + self.ReccLbl.frame.size.height , width: self.ItemCollection.frame.size.width, height: self.ItemCollection.frame.size.height)

                 }
                 else {
                    self.CompanyOfferLbl.text = company_offers
                 }
                 
                break
            } }
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubViewController.dismissKeyboard))
        self.CommentView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SubViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SubViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
         self.Comment.delegate = self
       
    }
    
    @objc func dismissKeyboard()
    {
        CommentView.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -50
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 
    }

    func updateContentHeight(){
    ProTable.frame = CGRect(x: ProTable.frame.origin.x, y: ProTable.frame.origin.y, width: ProTable.frame.size.width, height: ProTable.contentSize.height)
    
        if self.collectionArray.count == 0
        {
            self.ProTable.frame = CGRect(x: self.ProTable.frame.origin.x, y: self.View1.frame.origin.y  + View1.frame.size.height  , width: self.ProTable.frame.size.width, height: self.ProTable.contentSize.height)
            
            self.RecLbl.isHidden = true
            self.ReccLbl.isHidden = true
            self.ItemCollection.isHidden = true
            
           self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: ProTable.frame.size.height + View1.frame.size.height + 10)
        }
        else
        {
    self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: ItemCollection.frame.size.height + ProTable.frame.size.height + View1.frame.size.height + 170)
        }
}
    
    override func viewDidAppear(_ animated: Bool) {
       
        height = self.ItemCollection.collectionViewLayout.collectionViewContentSize.height
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.ItemCollection.addObserver(self , forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
  
    
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let newHeight : CGFloat = self.ItemCollection.collectionViewLayout.collectionViewContentSize.height
        
        var frame : CGRect! = self.ItemCollection.frame
        frame.size.height = newHeight
        
        self.ItemCollection.frame = frame
        if self.collectionArray.count == 0
        {
            self.ProTable.frame = CGRect(x: self.ProTable.frame.origin.x, y: self.View1.frame.origin.y  + View1.frame.size.height  , width: self.ProTable.frame.size.width, height: self.ProTable.contentSize.height)
            
            self.RecLbl.isHidden = true
            self.ReccLbl.isHidden = true
            self.ItemCollection.isHidden = true
            
            self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: ProTable.frame.size.height + View1.frame.size.height + 10)
        }
        else
        {
            self.ItemCollection.isHidden = false
            self.RecLbl.isHidden = false
            self.ReccLbl.isHidden = false
            
            ProTable.frame = CGRect(x: ProTable.frame.origin.x, y: ItemCollection.frame.origin.y + ItemCollection.frame.size.height, width: ProTable.frame.size.width, height: ProTable.contentSize.height)
            
            self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: ItemCollection.frame.size.height + ProTable.frame.size.height + View1.frame.size.height + 25)
        }
        
      
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
                self.ItemCollection.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    
    
    override func viewDidLayoutSubviews(){
      ProTable.frame = CGRect(x: ProTable.frame.origin.x, y: ProTable.frame.origin.y, width: ProTable.frame.size.width, height: ProTable.contentSize.height)
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
            NameLbl.fadeIn()
            CatLbl.fadeIn()
    
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         if ( MainScrollView.contentOffset == CGPoint(x : 0, y : 0) )
         {
            NameLbl.fadeOut()
            CatLbl.fadeOut()
        }
    }

  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == DescribeCollection)
        {
            return self.collectionArray.count
        }
        else
        {
            
            return self.collectionArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == DescribeCollection)
        {
        let cell = DescribeCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! DescCell
            
            cell.AddBtn.layer.borderWidth = 1.0
            cell.AddBtn.layer.cornerRadius = 3
            cell.AddBtn.layer.borderColor = UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1).cgColor
            cell.AddBtn.setTitleColor(UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1), for: .normal)
            
            cell.AddBtn.addTarget(self, action: #selector(SubViewController.inquiredesc(_:)), for: UIControlEvents.touchUpInside)
            cell.AddBtn.tag = (indexPath as NSIndexPath).row
            
            cell.ProTitle.numberOfLines = 0
            cell.ProTitle.lineBreakMode = .byWordWrapping
            
           
            let product = self.collectionArray[indexPath.item]
            cell.product = product
   
       let inq =  product.product_enquiry
          
                if (inq == 1)
                {
                    let image = UIImage(named: "tick")
                      cell.AddBtn.setImage(image, for: .normal)
                      cell.AddBtn.setTitle("",for: .normal)
                }
            return cell
        }
        else{
            
            let cell = ItemCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! SubCell
            cell.AddBtn.layer.borderWidth = 1.0
            cell.AddBtn.layer.cornerRadius = 3
            cell.AddBtn.layer.borderColor = UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1).cgColor
            cell.AddBtn.setTitleColor(UIColor(red: 22 / 255 , green: 160 / 255, blue: 133 / 255, alpha:1), for: .normal)
            
            
            cell.AddBtn.addTarget(self, action: #selector(SubViewController.inquire(_:)), for: UIControlEvents.touchUpInside)
            cell.AddBtn.tag = (indexPath as NSIndexPath).row
            
            
            
            cell.ProTitle.numberOfLines = 0
            cell.ProTitle.lineBreakMode = .byWordWrapping
            
            
            let product = self.collectionArray[indexPath.item]
            cell.product = product
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let i = IndexPath(item:indexPath.item, section: 0)
        DescribeCollection.reloadData()
        DescribeCollection.scrollToItem(at: i, at: .top, animated: false)
        View4.isHidden = false
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray[section].productsA?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SubTableCell = ProTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! SubTableCell
        
        cell.Add.addTarget(self, action: #selector(SubViewController.inquiretable(_:)), for: UIControlEvents.touchUpInside)
     
        
        
        cell.ProTitle.numberOfLines = 0
        cell.ProTitle.lineBreakMode = .byWordWrapping
        
        cell.ProPack.numberOfLines = 0
        cell.ProPack.lineBreakMode = .byWordWrapping
        
        cell.product = tableArray[indexPath.section].productsA?[indexPath.row]
       
         return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell")
        
        let label6 = headerView?.viewWithTag(100) as? UILabel
        label6?.frame = CGRect(x: 20 , y: 32, width: tableView.frame.size.width, height: 40)
        label6?.text = tableArray[section].group_title ?? ""
        
        let label7 = UILabel(frame:CGRect(x: 0 , y: 25, width: tableView.frame.size.width, height: 40))
        label7.backgroundColor = UIColor.white
        
        headerView?.addSubview(label7)
        headerView?.addSubview(label6!)
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
        
        
    }
  
    @objc func inquiretable(_ sender : UIButton)
    {
        SubmitBtn.addTarget(self, action: #selector(submitBtnAction), for: UIControlEvents.touchUpInside)
        
        CancelBtn.addTarget(self, action: #selector(cancelsubmitBtnAction), for: UIControlEvents.touchUpInside)
        
        CommentView.isHidden = false
        point = sender.convert(CGPoint.zero, to: self.ProTable as UIView)
        let indexPath: IndexPath! = self.ProTable.indexPathForRow(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ProTable.cellForRow(at: index) as! SubTableCell
        productID = cell.productid as String
        
    }
    
    
    @objc func inquire(_ sender : UIButton)
    {
        CommentView.isHidden = false
        point = sender.convert(CGPoint.zero, to: self.ItemCollection as UIView)
        let indexPath: IndexPath! = self.ItemCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ItemCollection.cellForItem(at: index) as! SubCell
        productID = cell.productid as String
        SubmitBtn.addTarget(self, action: #selector(CollectionsubmitBtnAction), for: UIControlEvents.touchUpInside)
        CancelBtn.addTarget(self, action: #selector(cancelCollectionsubmitBtnAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func inquiredesc(_ sender : UIButton)
    {
        
        CommentView.isHidden = false
        point = sender.convert(CGPoint.zero, to: self.DescribeCollection as UIView)
        let indexPath: IndexPath! = self.DescribeCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.DescribeCollection.cellForItem(at: index) as! DescCell
        productID = cell.productid as String
        SubmitBtn.addTarget(self, action: #selector(descCollectionsubmitBtnAction), for: UIControlEvents.touchUpInside)
        CancelBtn.addTarget(self, action: #selector(canceldescCollectionsubmitBtnAction), for: UIControlEvents.touchUpInside)
        
    }
    
    func flowLayout()
    {
        let flowlayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset.left = 10.0;
        flowlayout.sectionInset.right = 10.0;
        flowlayout.itemSize.width = ( self.view.frame.width / 2.1 - 7.5  )
        flowlayout.itemSize.height = flowlayout.itemSize.width + 30
        self.ItemCollection.collectionViewLayout = flowlayout
        
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func BtnAction(_ sender: AnyObject)
    {
        View4.isHidden = true
    }
   
    @IBAction func submitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.ProTable.indexPathForRow(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ProTable.cellForRow(at: index) as! SubTableCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]
    
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let image = UIImage(named: "tick")
                    cell.Add.setImage(image, for: .normal)
                    cell.Add.setTitle("",for: .normal)
                    self.CommentView.isHidden = true
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                 self.CommentView.isHidden = true
                break
                
            }
        }
        
        
    }
    
    @IBAction func CollectionsubmitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.ItemCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ItemCollection.cellForItem(at: index) as! SubCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let image = UIImage(named: "tick")
                    cell.AddBtn.setImage(image, for: .normal)
                    cell.AddBtn.setTitle("",for: .normal)
                    self.CommentView.isHidden = true
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                 self.CommentView.isHidden = true
                break
                
            }
        }
        
        
    }
    
    @IBAction func descCollectionsubmitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.DescribeCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.DescribeCollection.cellForItem(at: index) as! DescCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]

        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let image = UIImage(named: "tick")
                    cell.AddBtn.setImage(image, for: .normal)
                    cell.AddBtn.setTitle("",for: .normal)
                    self.CommentView.isHidden = true
                    SharedManager.dismissHUD(viewController: self)
                    
                }
                break
                
            case .failure(_):
                
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                 self.CommentView.isHidden = true
                break
                
            }
        }
        
        
    }
    
    @IBAction func cancelsubmitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.ProTable.indexPathForRow(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ProTable.cellForRow(at: index) as! SubTableCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                          }
                break
                
            case .failure(_):
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.CommentView.isHidden = true
                break
                
            }
        }
        
        
    }
    
    @IBAction func cancelCollectionsubmitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.ItemCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.ItemCollection.cellForItem(at: index) as! SubCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                   
                    let image = UIImage(named: "tick")
                    cell.AddBtn.setImage(image, for: .normal)
                    cell.AddBtn.setTitle("",for: .normal)
                    self.CommentView.isHidden = true
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.CommentView.isHidden = true
                break
                
            }
        }
        
        
    }
    
    @IBAction func canceldescCollectionsubmitBtnAction(_ sender: AnyObject)
    {
        self.CommentView.isHidden = true
        let indexPath: IndexPath! = self.DescribeCollection.indexPathForItem(at: point)
        
        let index:IndexPath = IndexPath( row : indexPath.row, section: indexPath.section)
        let cell = self.DescribeCollection.cellForItem(at: index) as! DescCell
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["product_id": self.productID , "comment": self.Comment.text]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/enquiry", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = data as! NSDictionary
                    
                    let image = UIImage(named: "tick")
                    cell.AddBtn.setImage(image, for: .normal)
                    cell.AddBtn.setTitle("",for: .normal)
                    self.CommentView.isHidden = true
                    SharedManager.dismissHUD(viewController: self)
                    
                }
                break
                
            case .failure(_):
                
                
                SharedManager.viewdismissHUD(viewController: self.loadView1)
                
                let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.CommentView.isHidden = true
                break
                
            }
        }
    }
    
    @IBAction func contactBtnAction(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "cont", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let obj:SubContacts = segue.destination as! SubContacts
        obj.CompDetailArray = self.CompDetailArray1
        obj.TitleName = self.CompNameLbl.text!
        
    }
}

