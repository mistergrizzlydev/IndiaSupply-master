//
//  Speaker.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/5/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
class Speaker: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var Table: UITableView!
  
       var SpeakersArray : NSArray  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Table.frame =  CGRect(x: 20, y:Table.frame.origin.y, width: self.view.frame.size.width - 40, height: Table.frame.size.height )
    }
    
    
    
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SpeakersArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell:SpeakerCell = Table.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell! as! SpeakerCell
        cell.Title.text = (SpeakersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "speaker_name") as? String
         cell.Place.text = (SpeakersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "speaker_description") as? String
        let imageURL = (SpeakersArray.object(at: (indexPath as NSIndexPath).row) as AnyObject).value(forKey: "speaker_image") as! String
        let trimmedUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!.trimmingCharacters(in: CharacterSet(charactersIn: "")).replacingOccurrences(of: " ", with: "%20") as String
        cell.BannerImage.loadImage(at: URL(string: trimmedUrl), placeholderImage: UIImage(named: "speaker_default"))
        
        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //   self.performSegue(withIdentifier: "Next", sender: self)
}

}
