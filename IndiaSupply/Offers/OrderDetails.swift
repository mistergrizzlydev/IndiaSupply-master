//
//  OrderDetails.swift
//  IndiaSupply
//
//  Created by Sud on 07/03/18.
//  Copyright © 2018 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class OrderDetails : UIViewController{
    @IBOutlet var NumberOfItemView : UIView!
    @IBOutlet var AddNewAddressView : UIView!
    @IBOutlet var NoAddressView : UIView!
    @IBOutlet var ConfirmAndPay : UIButton!
    @IBOutlet var SavedAmountTextNotify : UILabel!
    var OffID:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfirmAndPay.backgroundColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
        
        self.SavedAmountTextNotify.layer.borderWidth = 1
        self.SavedAmountTextNotify.layer.borderColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1).cgColor
        self.SavedAmountTextNotify.textColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1)
        
        self.NumberOfItemView.layer.borderWidth = 1
        self.NumberOfItemView.layer.borderColor = UIColor(red: 0 / 255 , green: 150 / 255, blue: 136 / 255, alpha:1).cgColor
        
        self.AddNewAddressView.layer.borderWidth = 0.5
        self.AddNewAddressView.layer.borderColor = UIColor.gray.cgColor
        
        self.NoAddressView.layer.borderWidth = 0.5
        self.NoAddressView.layer.borderColor = UIColor.gray.cgColor
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let parameter: [String : String] = ["offer_id": self.OffID ]
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.2/checkout", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print("URL","http://34.210.142.70/isdental/api/v2.1.1/checkout")
                    let json = data as! NSDictionary
                    print("JSON", json)
      
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
        
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
}
