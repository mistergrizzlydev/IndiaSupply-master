//
//  InquiriesPage.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/13/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
class InquiriesPage: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet var Table: UITableView!
    @IBOutlet var Name: UILabel!
    var NameString : String = ""
    
    var TableArray : NSArray  = []
    
     @IBOutlet  var novalue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = NameString
       
        if (TableArray.count == 0)
        {
            novalue.isHidden = false
        }
        else
        {
             novalue.isHidden = true
            
        }
        Table.frame =  CGRect(x: 20, y:Table.frame.origin.y, width: self.view.frame.size.width - 40, height: Table.frame.size.height )
        
       
        
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableCellInquiry = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! TableCellInquiry
    
        cell.productname.numberOfLines = 0
        cell.productname.lineBreakMode = .byWordWrapping
        
        cell.companyname.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "company_name") as? String
        cell.ticketnumber.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "enquiry_ticket_number") as? String
        cell.productname.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_name") as? String
        cell.product_description.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_description") as? String
        cell.product_price.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_price") as? String
     
            cell.comment.text = (TableArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "enquiry_comment") as! String
   
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
}



