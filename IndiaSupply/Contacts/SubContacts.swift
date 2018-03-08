//
//  SubContacts.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/3/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire

class SubContacts : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
   
    @IBOutlet  var BackButton: UIButton!
    @IBOutlet  var HideButton: UIButton!
    @IBOutlet  var BrandTitleName: UILabel!
    var TitleName:String = ""
    @IBOutlet  var Table: UITableView!
    var CompDetailArray : [companycontacts] = []
   @IBOutlet  var MainScrollView: UIScrollView!
      @IBOutlet  var loadView1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        BrandTitleName.text = TitleName
        MainScrollView.autoresizesSubviews = true
       
    
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.Table.frame = CGRect(x: self.Table.frame.origin.x, y: self.Table.frame.origin.y, width: self.Table.frame.size.width, height: CGFloat(110 * CompDetailArray.count) )
        self.Table.reloadData()
        self.MainScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,height: self.Table.frame.size.height   )
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CompDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SubContactsCell = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! SubContactsCell
    
        
        cell.CallBtn.addTarget(self, action: #selector(SubContacts.CallContact(_:)), for: UIControlEvents.touchUpInside)
        cell.CallBtn.tag = (indexPath as NSIndexPath).row


        cell.MailBtn.addTarget(self, action: #selector(SubContacts.MailContact(_:)), for: UIControlEvents.touchUpInside)
        cell.MailBtn.tag = (indexPath as NSIndexPath).row

        cell.FavBtn.addTarget(self, action: #selector(SubContacts.addfav(_:)), for: UIControlEvents.touchUpInside)
        cell.FavBtn.tag = (indexPath as NSIndexPath).row

        let product = self.CompDetailArray[indexPath.item]
        cell.product = product
        
        return cell
        
    }
    
    @objc func addfav(_ sender : UIButton)
    {
        SharedManager.ViewshowHUD(viewController: self.loadView1)
        
        
        let index:IndexPath = IndexPath(row: sender.tag, section: 0)
         let cell = self.Table.cellForRow(at: index) as! SubContactsCell
        let boolNumber = cell.compID

        let loginkey = UserDefaults.standard.object(forKey: "loginkey") as! String

        let parameter: [String : String] = ["type": "3" , "type_id": boolNumber ]

        let params: [String: String] = ["user-login-key" : loginkey , "api-key" : "ebaa3e8571444005cc0b609824e90dc8"]

        Alamofire.request("http://34.210.142.70/isdental/api/v2.1.1/favourite", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: params).responseJSON { (response:DataResponse<Any>) in

            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = data as! NSDictionary


                    let message = json.object(forKey: "message") as! String

                    if ( message == "Favourite added successfully")
                    {
                         cell.favImage.image = UIImage(named: "star-9" )

                        let alert = UIAlertController(title:nil, message:"Favourite added successfully", preferredStyle: UIAlertControllerStyle.alert)
                
                        self.present(alert, animated: true, completion: nil)
                        
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                    else
                    {

                        cell.favImage.image = UIImage(named: "star-7" )
                    }
                   SharedManager.viewdismissHUD(viewController: self.loadView1)
                }
                break

            case .failure(_):

                    SharedManager.viewdismissHUD(viewController: self.loadView1)

                     let alert = UIAlertController(title:nil, message:"No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                     alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                break

            }
        }
    }

    @objc func CallContact(_ sender : UIButton)
    {

        let index:IndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.Table.cellForRow(at: index) as! SubContactsCell
        
        let phoneNumber = cell.phoneno

        let Number =   phoneNumber.replacingOccurrences(of: " ", with: "")
        let url: NSURL = URL(string:  "tel://" + Number)! as NSURL
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }

    }

    @objc func MailContact(_ sender : UIButton)
    {
         let index:IndexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.Table.cellForRow(at: index) as! SubContactsCell


        let email = cell.emailid
        let toRecipents = [email]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self

        mc.setToRecipients(toRecipents as? [String])

        self.present(mc, animated: true, completion: nil)

    }
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
   
    
}

