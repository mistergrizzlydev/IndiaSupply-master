//
//  AddRequest.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/9/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class AddRequest: UIViewController, UITableViewDataSource, UITableViewDelegate
{
     @IBOutlet  var View1: UIView!
    
     @IBOutlet  var ReqView: UIView!
    
    @IBOutlet  var TraView: UIView!
    @IBOutlet  var ProImg: FLImageView!
    
    @IBOutlet var ModelLbl: UILabel!
    @IBOutlet  var SerialLbl: UILabel!
    
     @IBOutlet  var reqLbl: UILabel!
    @IBOutlet  var ReqTable: UITableView!
     var proid:String = ""
    var list : NSArray  = ["Request 1", "Request 2", "Request 3", "Request 4", "Request 5", "Request 6", "Request 7", "Request 8", "Request 9", "Request 10", "Request 11", "Request 12"]
    
    @IBOutlet  var Desc: UITextView!
    
    @IBOutlet  var Submit: UIButton!
    
    var ProAddlist : NSArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReqView.isHidden = true
        View1.isHidden = true
        
        
        View1.layer.borderWidth = 0.5
        View1.layer.borderColor = UIColor.lightGray.cgColor
        
        View1.layer.shadowOffset = CGSize(width: 0, height: 2)
        View1.layer.shadowColor = UIColor.black.cgColor
        View1.layer.shadowRadius = 1
        View1.layer.shadowOpacity = 0.5
        View1.layer.masksToBounds = false;
        View1.clipsToBounds = false;

        Desc.isHidden = true
        Desc.textContainer.maximumNumberOfLines = 6;
        Desc.textContainer.lineBreakMode = .byWordWrapping;
        
        Desc.layer.cornerRadius = 2.0
        Desc.layer.borderWidth = 0.5
        Desc.layer.borderColor = UIColor.lightGray.cgColor
     
         Submit.isHidden = true
        reqLbl.isHidden = true
        self.ReqTable.frame = CGRect(x: 20, y: ReqTable.frame.origin.y , width: self.ReqTable.frame.width - 20, height: 500)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GetStarted.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GetStarted.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GetStarted.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        ReqTable.frame = CGRect(x: ReqTable.frame.origin.x, y: ReqTable.frame.origin.y, width: ReqTable.frame.size.width, height: ReqTable.contentSize.height)
    
    }
    
    
    override func viewDidLayoutSubviews(){
        ReqTable.frame = CGRect(x: ReqTable.frame.origin.x, y: ReqTable.frame.origin.y, width: ReqTable.frame.size.width, height: ReqTable.contentSize.height)
        ReqTable.reloadData()
    }
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func ModelAction(_ sender: AnyObject)
    {
        if (ProAddlist.count == 0)
        {
            let alert = UIAlertController(title:nil, message:"No Products", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
      ReqView.isHidden = false
    }
    }
    @IBAction func SerialAction(_ sender: AnyObject)
    {
        ReqView.isHidden = false
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProAddlist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AddReqCell = ReqTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! AddReqCell
       
         cell.ReqTitle.text =  (ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_name") as? String
        cell.ReqDetail?.text =  NSString(format:"SR : %@", ((ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_serial_number") as? String)!) as String
        cell.textLabel?.font = UIFont .systemFont(ofSize: 13)
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(AddProducts.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tap.cancelsTouchesInView = false
        return cell

        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        ReqView.isHidden = true
        ModelLbl.text = NSString(format:"%@", ((ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_model_number") as? String)!) as String
        SerialLbl.text = NSString(format:"%@", ((ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_serial_number") as? String)!) as String
        
        proid = NSString(format:"%@", ((ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_id") as? CVarArg)!) as String
       
        let imageURL = (ProAddlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_image") as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        ProImg.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        
       View1.isHidden = false
        Submit.isHidden = false
        reqLbl.isHidden = false
        Desc.isHidden = false
//        self.Desc.frame = CGRect(x: 20, y: View1.frame.origin.y +  self.View1.frame.height + 60 , width: self.Desc.frame.width , height: self.Desc.frame.height)
//       
//        
//        self.reqLbl.frame = CGRect(x: 20, y: Desc.frame.origin.y - 20 , width: self.reqLbl.frame.width , height: self.reqLbl.frame.height)
//        
//        
//        self.Submit.frame = CGRect(x: 20, y: Desc.frame.origin.y +  self.Desc.frame.height + 90
//            , width: self.Submit.frame.width, height: self.Submit.frame.height)
        
    }
    
    @IBAction func AddReqBtnAction(_ sender: AnyObject)
    {
        view.endEditing(true)
        SharedManager.showHUD(viewController: self)
        
        
        
        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String
        
        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]
        
        
        let parameter: [String : String] = ["product_id": proid, "description": Desc.text! ]
        
        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/user/request", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let json = data as! NSDictionary
                    

                    
                    let message = json.object(forKey: "message") as! String
                    if ( message == "Service request generated successfully")
                    {
                        
                        let alert = UIAlertController(title:nil, message:"Service request generated successfully", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SharedManager.dismissHUD(viewController: self)
                    }
                        
                    else  if ( message == "Product already exist.")
                    {
                        
                        let alert = UIAlertController(title:nil, message:"Product already exist.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SharedManager.dismissHUD(viewController: self)
                    }
                    else
                    {
                        
                        let alert = UIAlertController(title:nil, message:"Please try again later", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SharedManager.dismissHUD(viewController: self)
                    }
                    
                    SharedManager.dismissHUD(viewController: self)
                }
                break
                
            case .failure(_):
                
                break
                
            }
        }
        
    }
}

