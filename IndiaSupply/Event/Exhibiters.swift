//
//  Exhibiters.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/5/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
class Exhibiters: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    
    @IBOutlet var Table: UITableView!
  
    @IBOutlet  var LineLbl: UILabel!
    
    @IBOutlet  var BackBtn: UIButton!
    @IBOutlet  var CrossBtn: UIButton!
    
    
     var ExhibitersArray : NSArray  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CrossBtn.isHidden = true
        
        CrossBtn.frame =  BackBtn.frame
        Table.frame =  CGRect(x: 20, y:Table.frame.origin.y, width: self.view.frame.size.width - 40, height: Table.frame.size.height )

    
    }    
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ExhibitersArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ExhibitersCell = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! ExhibitersCell
        
        
        cell.Title.text = (ExhibitersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "exhibitor_name") as? String
//        cell.Place.text = (ExhibitersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "exhibitor_description") as? String
//        let imageURL = (ExhibitersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "exhibitor_image") as! String
//        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
//        cell.BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "place"))
        

        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // self.performSegue(withIdentifier: "Next", sender: self)
    }
    
    
    
    
}

