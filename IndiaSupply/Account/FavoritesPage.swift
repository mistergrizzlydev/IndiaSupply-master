//
//  FavoritesPage.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/24/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import MessageUI

class FavoritesPage: UIViewController, UITableViewDataSource, UITableViewDelegate , MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet var Table: UITableView!
    @IBOutlet var Name: UILabel!
     var NameString : String = ""
    
    var TableArray : NSArray  = []
    @IBOutlet  var novalue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = NameString

    Table.frame =  CGRect(x: 20, y:Table.frame.origin.y, width: self.view.frame.size.width - 40, height: Table.frame.size.height )
   
        if (TableArray.count == 0)
        {
            novalue.isHidden = false
        }
        else
        {
            novalue.isHidden = true
            
        }
    }

    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableCellFav = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! TableCellFav
        
        cell.BrandTitle.text =  (self.TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "contact_name")  as? String
        
        let Type = (self.TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "contact_type")  as? Int
        
        if (Type == 1) {
            
            cell.BrandDesc.text =  "Company Office"
            
        }
            
        else if (Type == 2)  {
            
            cell.BrandDesc.text = "Sales Office"
            
        }
        else if (Type == 3)  {
            
            cell.BrandDesc.text =  "Service Office"
            
        }
        else if (Type == 4)  {
            
            cell.BrandDesc.text =  "Dealer/Distributor"
            
        }
        
        cell.BrandPlace.text = (self.TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "contact_location")  as? String
        
        
        let imageURL =  (self.TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "contact_image")  as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.BrandImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        
        cell.CallBtn.addTarget(self, action: #selector(FavoritesPage.CallContact(_:)), for: UIControlEvents.touchUpInside)
        cell.CallBtn.tag = (indexPath as NSIndexPath).row
        
        cell.BrandTitle.numberOfLines = 0
        cell.BrandTitle.lineBreakMode = .byWordWrapping
        
        
        cell.MailBtn.addTarget(self, action: #selector(FavoritesPage.MailContact(_:)), for: UIControlEvents.touchUpInside)
        cell.MailBtn.tag = (indexPath as NSIndexPath).row
        
        
        
        return cell
        
    }
    
    @objc func CallContact(_ sender : UIButton)
    {
        let index:IndexPath = IndexPath(row: sender.tag, section: 0)
        
        let phoneNumber = (self.TableArray.object(at: (index as NSIndexPath).row) as AnyObject).value(forKey: "contact_phone") as! String
        
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
        
        
        let email = (self.TableArray.object(at: (index as NSIndexPath).row) as AnyObject).value(forKey: "contact_email") as? String
        let toRecipents = [email]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipents as? [String])
        
        self.present(mc, animated: true, completion: nil)
        
    }
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
}

