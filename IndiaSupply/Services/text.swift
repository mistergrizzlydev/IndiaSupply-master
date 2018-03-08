//
//  text.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/6/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit

class text: UITextView {
      var label6: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeight), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  
    
     //    label6 = UILabel(frame: CGRect(x: 0 , y: self.frame.size.height - 1, width: self.frame.size.width, height: 1))
       // label6.backgroundColor = UIColor.black
       // self.addSubview(label6)
    
        self.textContainer.maximumNumberOfLines = 6;
        self.textContainer.lineBreakMode = .byWordWrapping;
        
    
    }
    
    @objc func updateHeight() {
       
        
         var newFrame = frame
         
         let fixedWidth = frame.size.width
         let newSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
         
         newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
         self.frame = newFrame
        
        self.textContainer.maximumNumberOfLines = 6;
        self.textContainer.lineBreakMode = .byWordWrapping;
        
       // let nFrame = CGRect(x: 0 , y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        //label6.frame = nFrame
        
//        AddRequest().Submit.frame = CGRect(x: self.frame.origin.x , y: self.frame.origin.y + self.frame.size.height + 50, width: self.frame.size.width, height: 35)
        // suggest searching stackoverflow for "uiview animatewithduration" for frame-based animation
        // or "animate change in intrinisic size" to learn about a more elgant solution :)
    }
}
