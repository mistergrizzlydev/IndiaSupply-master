//
//  GeneralInfo.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/5/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//


import UIKit
class GeneralInfo: UIViewController, UIWebViewDelegate
{
    @IBOutlet var Web: UIWebView!
    var GeneralID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        Web.loadHTMLString(GeneralID, baseURL: nil)
         Web.scrollView.bounces = false
        
    }
    
    
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
    }
    
}
