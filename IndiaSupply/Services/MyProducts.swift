//
//  MyProducts.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/9/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Alamofire

class MyProducts: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var ProductTable: UITableView!
    var Productlist : NSArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if(Productlist.count == 0)
        {
            let alert = UIAlertController(title:nil, message:"No Products", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        ProductTable.frame =  CGRect(x: 20, y:ProductTable.frame.origin.y, width: self.view.frame.size.width - 40, height: ProductTable.frame.size.height )
        
    }
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.Productlist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyProductCell = ProductTable.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! MyProductCell
        let imageURL = (Productlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_image") as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.ProImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        cell.ProName.text = (Productlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_name") as? String
        cell.ModelNumber.text = (Productlist.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "product_description") as? String
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}
