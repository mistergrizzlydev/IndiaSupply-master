//
//  MyRequest.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/9/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
class MyRequest: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var ReqTable: UITableView!
    
    var Requestlist : NSArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReqTable.frame =  CGRect(x: 20, y:ReqTable.frame.origin.y, width: self.view.frame.size.width - 40, height: ReqTable.frame.size.height )
        
        if(Requestlist.count == 0)
        {
            let alert = UIAlertController(title:nil, message:"No Products", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }

    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.Requestlist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyRequestCell = ReqTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! MyRequestCell
        let imageURL = (Requestlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_image") as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.ReqImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "date_image"))
        cell.ReqTitle.text = (Requestlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_ticket_number") as? String
        cell.ReqDetail.text = NSString(format:"%@  -  %@", ((Requestlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_serial_number") as? String)!,((Requestlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "request_description") as? String)!) as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
}
