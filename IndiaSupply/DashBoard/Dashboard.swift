//
//  Dashboard.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/26/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import ObjectMapper
import AlamofireObjectMapper

class Dashboard: UIViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate , UICollectionViewDelegateFlowLayout{
    
    var indID:String = ""
    var arrcount: Int = 0
    
    @IBOutlet  var NoInternetView : UIView!
    @IBOutlet  var View1: UIView!
    @IBOutlet  var View2: UIView!
    @IBOutlet  var MainScrollView: UIScrollView!
    
    @IBOutlet  var BannerCollection: UICollectionView!
    
    @IBOutlet  var lbl1: UILabel!

    @IBOutlet  var View3: UIView!
    @IBOutlet  var CountLbl: UILabel!
    
    var CollectionArray: [bannerDetail] = []
    var TableArray : [companyDetail] = []
    
    var ResArray : [RealmFeatured] = []
    
    @IBOutlet  var ProductTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.MainScrollView.isHidden = true
          SharedManager.showHUD(viewController: self)
         self.NoInternetView.isHidden = true
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/featured", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseObject { (response: DataResponse<RealmFeatured>) in
            

            switch(response.result) {
            case .success(_):
                if let RealmFeaturedRes = response.result.value{
                    
                     self.NoInternetView.isHidden = true
                    
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: RealmFeaturedRes.bannerDetails!)
                    UserDefaults.standard.set(encodedData, forKey: "bannerArray")
                    
                    let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: RealmFeaturedRes.companyDetails!)
                    UserDefaults.standard.set(encodedData1, forKey: "companyArray")
                    

                    self.CollectionArray = (RealmFeaturedRes.bannerDetails! as NSArray) as! [bannerDetail]
                    self.TableArray = (RealmFeaturedRes.companyDetails! as NSArray) as! [companyDetail]
            
                
                    self.ProductTable.reloadData()
                    self.ProductTable.frame = CGRect(x: self.ProductTable.frame.origin.x, y: self.ProductTable.frame.origin.y, width: self.ProductTable.frame.size.width, height: self.ProductTable.contentSize.height)
                    
                    self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.View2.frame.size.height + self.ProductTable.frame.size.height + 70 )
                    self.BannerCollection.reloadData()
                   
                      self.MainScrollView.isHidden = false
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
               SharedManager.dismissHUD(viewController: self)
             
//               self.NoInternetView.isHidden = true
//
//               let decoded = UserDefaults.standard.object(forKey: "bannerArray") as? NSData
//               let array = NSKeyedUnarchiver.unarchiveObject(with: decoded! as Data) as! [bannerDetail]
//               self.CollectionArray = array
//
//               let decoded1 = UserDefaults.standard.object(forKey: "companyArray") as? NSData
//               let array1 = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companyDetail]
//               self.TableArray = array1
//
//               self.ProductTable.reloadData()
//               self.ProductTable.frame = CGRect(x: self.ProductTable.frame.origin.x, y: self.ProductTable.frame.origin.y, width: self.ProductTable.frame.size.width, height: self.ProductTable.contentSize.height)
//
//               self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.View2.frame.size.height + self.ProductTable.frame.size.height + 70 )
//               self.BannerCollection.reloadData()
//
//               self.MainScrollView.isHidden = false

               self.NoInternetView.isHidden = false
               
                break
                
            }
        }
        
        
        self.ProductTable.delegate = self
        self.ProductTable.dataSource = self
    

        lbl1.frame =  CGRect(x: -10, y:View1.frame.size.height - 2, width: self.view.frame.size.width + 20, height: 0.9)

        View2.frame =  CGRect(x: 20, y:View2.frame.origin.y , width: self.view.frame.size.width - 40  , height: View2.frame.size.height )

        self.BannerCollection.frame = CGRect(x:0, y: BannerCollection.frame.origin.y  , width: self.View2.frame.width , height: ( self.view.frame.width / 1.7 ))
        self.View3.frame = CGRect(x: 0, y: BannerCollection.frame.origin.y + BannerCollection.frame.size.height - 5 , width: self.view.frame.width , height: 35 )
        self.ProductTable.frame = CGRect(x: 20, y: View3.frame.origin.y + View3.frame.size.height, width: self.view.frame.width - 20, height: 300)

  //      self.flowLayout()
        
    }
    override func viewWillAppear(_ animated: Bool)
        
    {
        self.NoInternetView.isHidden = true
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/home/featured", method: .get, parameters: nil, encoding: URLEncoding.default, headers: params).responseObject { (response: DataResponse<RealmFeatured>) in
            
            switch(response.result) {
            case .success(_):
                if let RealmFeaturedRes = response.result.value{
                    
                    self.NoInternetView.isHidden = true
                    
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: RealmFeaturedRes.bannerDetails!)
                    UserDefaults.standard.set(encodedData, forKey: "bannerArray")
                    
                    let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: RealmFeaturedRes.companyDetails!)
                    UserDefaults.standard.set(encodedData1, forKey: "companyArray")
                    
                    
                    self.CollectionArray = (RealmFeaturedRes.bannerDetails! as NSArray) as! [bannerDetail]
                    self.TableArray = (RealmFeaturedRes.companyDetails! as NSArray) as! [companyDetail]
                    
                    self.ProductTable.reloadData()
                    self.BannerCollection.reloadData()
                    self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.View2.frame.size.height + self.ProductTable.frame.size.height + 70 )
                    self.MainScrollView.isHidden = false
                    SharedManager.dismissHUD(viewController: self)
                    
                    
                }
                break
                
            case .failure(_):
                SharedManager.dismissHUD(viewController: self)
//                self.NoInternetView.isHidden = true
//
//                let decoded = UserDefaults.standard.object(forKey: "bannerArray") as? NSData
//                let array = NSKeyedUnarchiver.unarchiveObject(with: decoded! as Data) as! [bannerDetail]
//                self.CollectionArray = array
//
//                let decoded1 = UserDefaults.standard.object(forKey: "companyArray") as? NSData
//                let array1 = NSKeyedUnarchiver.unarchiveObject(with: decoded1! as Data) as! [companyDetail]
//                self.TableArray = array1
//
//
//                self.ProductTable.reloadData()
//                self.BannerCollection.reloadData()
//                self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.View2.frame.size.height + self.ProductTable.frame.size.height + 70 )
//                self.MainScrollView.isHidden = false
//                SharedManager.dismissHUD(viewController: self)
//                self.MainScrollView.isHidden = false

                self.NoInternetView.isHidden = false
                
                break
                
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
 
    }
    
    override func viewDidLayoutSubviews(){

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return TableArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell:TableCell = ProductTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! TableCell
        
        
        let product = self.TableArray[indexPath.item]
        cell.product = product
        
        return cell
       
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       // indID = String(indexPath.row)
        self.performSegue(withIdentifier: "Next", sender: indexPath)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath:IndexPath = (sender as? IndexPath)!
        let cell = ProductTable.cellForRow(at: indexPath) as! TableCell
    
        let obj:SubViewController = segue.destination as! SubViewController
        obj.CompID = cell.compID
        obj.indexID = indexPath

        arrcount = TableArray.count
        obj.indexcount = arrcount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.CollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

         return CGSize(width: /*(*/ self.View2.frame.width /*/ 1.5 ) + 2 */, height: self.BannerCollection.frame.height - 25   )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        let cell = BannerCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CollectionCell
        
        let product = self.CollectionArray[indexPath.item]
        cell.product = product
        
    return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
       
        let cell = BannerCollection.cellForItem(at: indexPath as IndexPath) as! CollectionCell
      
        if cell.bannertype == "2" {
            

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
              newViewController.CompID = cell.bannertypeid
            self.present(newViewController, animated: false, completion: nil)
        }
        else if cell.bannertype == "1" {
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SubEvent") as! SubEvent
            newViewController.EventID = cell.bannertypeid
            self.present(newViewController, animated: false, completion: nil)
        }
    }
    
    func flowLayout()
    {
        let flowlayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //    flowlayout.minimumInteritemSpacing = 140.0
        flowlayout.scrollDirection = .horizontal
        //flowlayout.minimumLineSpacing = 20.0
        flowlayout.sectionInset.left = 0.0;
        flowlayout.sectionInset.right = 0.0;
        flowlayout.itemSize.width = ( self.View2.frame.width)
        flowlayout.itemSize.height = flowlayout.itemSize.width
        self.BannerCollection.collectionViewLayout = flowlayout
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
}



