//
//  FaqPage.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/24/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
class FaqPage : UIViewController , UIWebViewDelegate
{
    
    @IBOutlet var WebView: UIWebView!
   
    @IBOutlet var Name: UILabel!
    var NameString : String = ""
    
    var webString : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           Name.text = NameString
            WebView.loadHTMLString(webString, baseURL: nil)
        WebView.scrollView.bounces = false
        
        
    }
    
    
    @IBAction func BackBtnAction(_ sender: AnyObject)
    {
        dismiss(animated: false, completion: nil)
}

}
