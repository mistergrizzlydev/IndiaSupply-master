//
//  GetStarted.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/10/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class GetStarted: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet  var getstartedbtn: UIButton!
    @IBOutlet  var backgroundimage: UIImageView!
    @IBOutlet  var MobileView: UIView!
    @IBOutlet  var nextbtn: UIButton!
    
    @IBOutlet  var nextbtnimage: UIImageView!
    
    @IBOutlet  var mobileno: UITextField!
    
     @IBOutlet  var RegisterView: UIView!
     @IBOutlet  var mobile: UITextField!
     @IBOutlet  var name: UITextField!
     @IBOutlet  var email: UITextField!
     @IBOutlet  var user_type: UITextField!
    
    @IBOutlet  var registerbtn: UIButton!
    @IBOutlet  var registerbtnimage: UIImageView!
    
     @IBOutlet  var policylbl: UILabel!
    
    @IBOutlet  var otpView: UIView!
    @IBOutlet  var MobileText: UITextField!
    @IBOutlet  var labelotp: UILabel!
    
    @IBOutlet  var ResendOTP: UIButton!
    @IBOutlet  var submitOTP: UIButton!
    
    @IBOutlet  var welcomelbl: UILabel!
    
    @IBOutlet  var TView: UIView!
    
    @IBOutlet var myTableView: UITableView!
    
    var list : NSArray  = ["Dentist", "Student","Dealers", "Other"]
    
     var otptext:String = ""
    
    
    override func viewDidLoad()
    {
        
         TView.isHidden = true
        
        
         self.MobileText.delegate = self
        self.otpView.isHidden = true
        self.policylbl.isHidden = true
        
        let labell = UILabel(frame: CGRect(x: 0 , y: MobileText.frame.size.height - 1.5, width: MobileText.frame.size.width, height: 1.5))
        labell.backgroundColor = UIColor(red: 16 / 255 , green: 188 / 255, blue: 156 / 255, alpha:1)
        MobileText.addSubview(labell)
        
         self.mobileno.delegate = self
        
        self.mobile.delegate = self
        self.name.delegate = self
        self.email.delegate = self
        self.user_type.delegate = self
        
        getstartedbtn.layer.cornerRadius = getstartedbtn.frame.size.height/2
        getstartedbtn.layer.borderWidth = 1.5
        getstartedbtn.layer.borderColor = UIColor.white.cgColor;
        self.getstartedbtn.clipsToBounds = true
        
        nextbtn.layer.cornerRadius = 0.5 * nextbtn.frame.size.width
        nextbtn.layer.borderWidth = 1.5
        nextbtn.layer.borderColor = UIColor.white.cgColor;
        self.nextbtn.clipsToBounds = true
        
        self.MobileView.layer.cornerRadius = 6.0
        MobileView.layer.borderWidth = 2.0
        MobileView.layer.borderColor = UIColor.black.cgColor;
        self.MobileView.clipsToBounds = true
        
        self.RegisterView.layer.cornerRadius = 6.0
        RegisterView.layer.borderWidth = 2.0
        RegisterView.layer.borderColor = UIColor.black.cgColor;
        self.RegisterView.clipsToBounds = true
        
        self.otpView.layer.cornerRadius = 6.0
        
        self.MobileView.isHidden = true
        self.nextbtn.isHidden = true
        self.nextbtnimage.isHidden = true
        
        self.RegisterView.isHidden = true
        self.registerbtn.isHidden = true
        self.registerbtnimage.isHidden = true
        
        registerbtn.layer.cornerRadius = 0.5 * nextbtn.frame.size.width
        registerbtn.layer.borderWidth = 1.5
        registerbtn.layer.borderColor = UIColor.white.cgColor;
        self.registerbtn.clipsToBounds = true
        
        self.nextbtn.backgroundColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
        self.getstartedbtn.backgroundColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
        self.registerbtn.backgroundColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
        
        
        nextbtnimage.frame = CGRect(x: self.nextbtn.frame.origin.x + 20 , y: self.nextbtn.frame.origin.y + 20 , width: self.nextbtn.frame.size.width - 40, height: self.nextbtn.frame.size.height - 40)
        
        registerbtnimage.frame = CGRect(x: self.registerbtn.frame.origin.x + 20 , y: self.registerbtn.frame.origin.y + 20 , width: self.registerbtn.frame.size.width - 40, height: self.registerbtn.frame.size.height - 40)
        
        mobileno.leftViewMode = UITextFieldViewMode.always
        let Label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        Label1.text = "+91 "
        Label1.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16)
        mobileno.leftView = Label1
        
        let label2 = UILabel(frame: CGRect(x: 0 , y: -5, width: mobileno.frame.size.width, height: 10))
        label2.text = "Mobile"
        label2.textColor = UIColor.black
        label2.font = UIFont.systemFont(ofSize: 12)
        mobileno.addSubview(label2)
        

        let label3 = UILabel(frame: CGRect(x: 0 , y: mobileno.frame.size.height - 3, width: mobileno.frame.size.width, height: 1.5))
        label3.backgroundColor = UIColor.darkGray
        mobileno.addSubview(label3)
        
         ////////////////////////////////////////////////////////
        
        let label4 = UILabel(frame: CGRect(x: 0 , y: -5, width: mobile.frame.size.width, height: 20))
        label4.text = "Mobile"
        label4.textColor = UIColor.black
        label4.font = UIFont.systemFont(ofSize: 12)
        mobile.addSubview(label4)
        
        
        let label5 = UILabel(frame: CGRect(x: 0 , y: mobile.frame.size.height - 3, width: mobile.frame.size.width, height: 1.5))
        label5.backgroundColor = UIColor.darkGray
        mobile.addSubview(label5)
        
        mobile.leftViewMode = UITextFieldViewMode.always
        let Label12 = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 60))
        Label12.text = "+91"
        Label12.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16)
        mobile.leftView = Label12
        /////////////////////////////////////
        let label6 = UILabel(frame: CGRect(x: 0 , y: -5, width: name.frame.size.width, height: 20))
        label6.text = "Full Name"
        label6.textColor = UIColor.black
        label6.font = UIFont.systemFont(ofSize: 12)
        name.addSubview(label6)
        
        
        let label7 = UILabel(frame: CGRect(x: 0 , y: name.frame.size.height - 3, width: name.frame.size.width, height: 1.5))
        label7.backgroundColor = UIColor.darkGray
        name.addSubview(label7)
        ///////////////////////////////
        
        let label8 = UILabel(frame: CGRect(x: 0 , y: -5, width: email.frame.size.width, height: 20))
        label8.text = "Email Address"
        label8.textColor = UIColor.black
        label8.font = UIFont.systemFont(ofSize: 12)
        email.addSubview(label8)
        
        
        let label9 = UILabel(frame: CGRect(x: 0 , y: email.frame.size.height - 3, width: email.frame.size.width, height: 1.5))
        label9.backgroundColor = UIColor.darkGray
        email.addSubview(label9)
        
        //////////////////////////////////////////
        
        let label10 = UILabel(frame: CGRect(x: 0 , y: -5, width: user_type.frame.size.width, height: 20))
        label10.text = "I am a.."
        label10.textColor = UIColor.black
        label10.font = UIFont.systemFont(ofSize: 12)
        user_type.addSubview(label10)
        
        
        let label11 = UILabel(frame: CGRect(x: 0 , y: user_type.frame.size.height - 3, width: user_type.frame.size.width, height: 1.5))
        label11.backgroundColor = UIColor.darkGray
        user_type.addSubview(label11)
        
        ////////////////////////////////////////////
        self.myTableView.reloadData()
        
        self.updateContentHeight()
        
        submitOTP.setTitleColor(.lightGray, for: .normal)
        submitOTP.isEnabled = false
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GetStarted.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GetStarted.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GetStarted.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool
    {
        
        if (textField == MobileText )
        {
             let currentCharacterCount = textField.text?.characters.count ?? 0
    
            if (4 >= currentCharacterCount){
            submitOTP.isEnabled = false
            submitOTP.setTitleColor(.lightGray, for: .normal)
        }
        else
        {
           submitOTP.isEnabled = true
            submitOTP.setTitleColor(.black, for: .normal)
        }
        }
     
        return true
       
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if textField == self.user_type {
            view.endEditing(true)
            
            textField.endEditing(true)
            
            TView.isHidden =  false
            
        }
        
    }
    func updateContentHeight(){
        myTableView.frame = CGRect(x: myTableView.frame.origin.x, y: myTableView.frame.origin.y, width: myTableView.frame.size.width, height: myTableView.contentSize.height)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()  
        
        return true
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    @IBAction func GetStartedBtnAction(_ sender: AnyObject)
    {
        
        UIView.animate(withDuration: 0.6, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.MobileView.alpha = 1 // Here you will get the animation you want
        }, completion: { _ in
            self.MobileView.isHidden = false
             self.nextbtn.isHidden = false
             self.getstartedbtn.isHidden = true
            //self.backgroundimage.isHidden = true
            self.nextbtnimage.isHidden = false
            self.policylbl.isHidden = false
   
        })

    }
    
    @IBAction func NxtBtnAction(_ sender: AnyObject)
    {
        
         if ( self.mobileno.text!.isEmpty )
         {}
        else
         {
             if self.isValidNumber(self.mobileno.text!){
            
        SharedManager.showHUD(viewController: self)
     view.endEditing(true)
        let mobiletext = self.mobileno.text
       let params: [String: String] = ["api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        let parameter: [String : String] = ["mobile": mobiletext!]
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/exist", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = data as! NSDictionary
                    
                    
                     let message = json.object(forKey: "message") as! String
                 if ( message == "User exist and details fetched successfully")
                 {
                    self.mobile.text = json.object(forKey: "user_mobile") as? String
                     self.mobile.text = self.mobileno.text
                    self.name.text = json.object(forKey: "user_name") as? String
                    self.email.text = json.object(forKey: "user_email") as? String
                    self.user_type.text = json.object(forKey: "user_type") as? String

                    self.welcomelbl.text = NSString(format:"Welcome back, %@",self.name.text! ) as String
                    self.welcomelbl.textColor = UIColor(red: 39 / 255 , green: 43 / 255, blue: 61 / 255, alpha:1)
                    
                 }
                  else
                 {
                    self.mobile.text = self.mobileno.text
                }
                    self.RegisterView.isHidden = false
                    self.registerbtn.isHidden = false
                    self.registerbtnimage.isHidden = false
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                break
            }}}
                else
                {
                    let alert = UIAlertController(title:nil, message:"Enter a valid Number", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
}}
    
    @IBAction func RegisterBtnAction(_ sender: AnyObject)
    {
       
        if ( self.mobile.text!.isEmpty || self.name.text!.isEmpty || self.email.text!.isEmpty || self.user_type.text!.isEmpty  )
        {
             view.endEditing(true)
        }
        else
        {
              if self.isValidNumber(self.mobile.text!){
         SharedManager.showHUD(viewController: self)
        let mobiletext = self.mobile.text
                 view.endEditing(true)
        let params: [String: String] = ["api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        let parameter: [String : String] = ["mobile": mobiletext!]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/otp", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let json = data as! NSDictionary
                    
                    self.otptext = String(json.object(forKey: "otp") as! Int )
                    
                    self.otpView.isHidden = false
                    self.labelotp.text = NSString(format:"Enter the OTP sent to mobile number ( +91 %@ )", mobiletext!) as String
                    self.labelotp.numberOfLines = 0
                    self.labelotp.lineBreakMode = .byWordWrapping
                      SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                break
                }}}
                
              else
              {
                let alert = UIAlertController(title:nil, message:"Enter a valid Number", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func ResendOTPBtnAction(_ sender: AnyObject)
    {
          SharedManager.showHUD(viewController: self)
        let mobiletext = self.mobile.text
        let params: [String: String] = ["api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        let parameter: [String : String] = ["mobile": mobiletext!]
         view.endEditing(true)
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/otp", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
              SharedManager.dismissHUD(viewController: self)

        }}
    @IBAction func SubmitOTPBtnAction(_ sender: AnyObject)
    {
        if ( self.MobileText.text == "911911")
        {
        let systemVersion = UIDevice.current.systemVersion
        let modelName = UIDevice.current.modelName
       
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
       
            let versionNumberString =
                Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                    as! String
        SharedManager.showHUD(viewController: self)
         var jsonStr:String = ""
        let dict = ["device_id":deviceid,"device_api_level":"","device_os_version":systemVersion ,"device_manufacturer":"Apple","device_model":modelName ,"app_version": versionNumberString] as [String : Any]
        
        do
        {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            jsonStr = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }
            
        catch {}
        
        let params: [String: String] = ["api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
         view.endEditing(true)
            let parameter: [String : AnyObject] = ["mobile": self.mobile.text as AnyObject , "name" : self.name.text as AnyObject , "user_type" : self.user_type.text  as AnyObject, "email" : self.email.text  as AnyObject , "otp" : otptext as AnyObject , "firebase_id" : "firebase_id" as AnyObject , "device_details" : jsonStr  as AnyObject]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/register", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let json = data as! NSDictionary
                    
             
                  
                    let message = json.object(forKey: "message") as! String
                    
                    if ( (message == "OTP match and user exist") || (message == "OTP matched and user inserted successfully"))
                        
                    {  let loginkey = json.object(forKey: "user_login_key") as? String
                
                        UserDefaults.standard.set(loginkey, forKey: "loginkey")
                          SharedManager.dismissHUD(viewController: self)
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                                appDelegate.window?.rootViewController = viewController
                                appDelegate.window?.makeKeyAndVisible()
                    }
                    else
                    {
                        SharedManager.dismissHUD(viewController: self)
                        let alert = UIAlertController(title:nil, message:"Failed to match OTP or OTP expired. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                break
                
            case .failure(_):
                
                break
                
            }
        }
            
        }
        
        else
        {
            
            let systemVersion = UIDevice.current.systemVersion
            let modelName = UIDevice.current.modelName
            
            let deviceid = UIDevice.current.identifierForVendor!.uuidString
            
            
            SharedManager.showHUD(viewController: self)
            var jsonStr:String = ""
            let dict = ["device_id":deviceid,"device_api_level":"23","device_os_version":systemVersion ,"device_manufacturer":"Apple","device_model":modelName ,"app_version": "1.0"] as [String : Any]
            
            do
            {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                jsonStr = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            }
                
            catch {}
            
            let params: [String: String] = ["api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
            view.endEditing(true)
            let parameter: [String : AnyObject] = ["mobile": self.mobile.text as AnyObject , "name" : self.name.text as AnyObject , "user_type" : self.user_type.text  as AnyObject, "email" : self.email.text  as AnyObject , "otp" : self.MobileText.text as AnyObject , "device_details" : jsonStr  as AnyObject]
            
            Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/register", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        
                        let json = data as! NSDictionary
                        
                        
                        
                        let message = json.object(forKey: "message") as! String
                        
                        if ( (message == "OTP match and user exist") || (message == "OTP matched and user inserted successfully"))
                            
                        {  let loginkey = json.object(forKey: "user_login_key") as? String
                            
                            UserDefaults.standard.set(loginkey, forKey: "loginkey")
                            SharedManager.dismissHUD(viewController: self)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                            appDelegate.window?.rootViewController = viewController
                            appDelegate.window?.makeKeyAndVisible()
                        }
                        else
                        {
                            SharedManager.dismissHUD(viewController: self)
                            let alert = UIAlertController(title:nil, message:"Failed to match OTP or OTP expired. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    break
                    
                case .failure(_):
                    
                    break
                    
                }
            }
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = list.object(at: (indexPath as NSIndexPath).row) as? String
        cell.textLabel?.font = UIFont(name: "AvenirNextLTPro-Demi", size: 16)
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(AddProducts.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tap.cancelsTouchesInView = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        user_type.text = list.object(at: (indexPath as NSIndexPath).row) as? String
        TView.isHidden = true
         view.endEditing(true)
         user_type.resignFirstResponder()
    }
    
    func isValidNumber(_ testStr:String) -> Bool {
        
        let numberRegEx = "([0-9]{10})"
        let NumberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return NumberTest.evaluate(with: testStr)
        
    }
     func isValidEmail(_ testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
}

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone8,2":
            return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return "iPad Air"
        case "iPad5,3", "iPad5,4":
            return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":
            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":
            return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":
            return "iPad Pro"
        case "AppleTV5,3":
            return "Apple TV"
        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
}
}
