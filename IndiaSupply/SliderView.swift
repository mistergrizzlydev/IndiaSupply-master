//
//  SliderView.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/7/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit


class SliderView: UIViewController
    
{
    
    @IBOutlet var pageControl: UIPageControl!
    var bannerImages:NSMutableArray = ["offer-tag-full-image", "events","contacts","service"]
    let maxImages = 3
    var imageIndex: NSInteger = 0
    
    @IBOutlet  var donebtn: UIButton!
    @IBOutlet  var nextbtn: UIButton!
    
    @IBOutlet  var titlelbl: UILabel!
    @IBOutlet  var desclbl: UILabel!
    
    @IBOutlet  var SliderImage: UIImageView!
    @IBOutlet  var btnImage: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        SliderImage.layer.shadowColor = UIColor.black.cgColor
        SliderImage.layer.shadowOffset = CGSize( width : 5, height : 8)
        SliderImage.layer.shadowOpacity = 0.5
        SliderImage.layer.shadowRadius = 0.0
        
        donebtn.isHidden = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        SliderImage.image = UIImage(named:"offer-tag-full-image")
        titlelbl.text = "Offers"
        desclbl.text = "Get Expo Offers"
        self.view.backgroundColor = UIColor(red: 212 / 255 , green: 108 / 255, blue: 108 / 255, alpha:1)
        
        
        btnImage.frame = CGRect(x: btnImage.frame.origin.x + 5, y: nextbtn.frame.origin.y + 5, width: btnImage.frame.size.width - 10, height: btnImage.frame.size.height - 10)
        
        self.configurePageControl()
    }
    
    func configurePageControl() {
        
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor(red: 171 / 255 , green: 178 / 255, blue: 185 / 255, alpha:1)
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        
    }
    
    @objc  func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right :
                
                pageControl.currentPage -= 1
                imageIndex -= 1
                
                if ( imageIndex < maxImages ) {
                    
                    donebtn.isHidden = true
                    nextbtn.isHidden = false
                    btnImage.isHidden = false
                }
                // check if index is in range
                
                if ( imageIndex == 0 ) {
                    
                    titlelbl.text = "Offers"
                    desclbl.text = "Get Expo Offers"
                    self.view.backgroundColor = UIColor(red: 212 / 255 , green: 108 / 255, blue: 108 / 255, alpha:1)
                    
                }
                else if ( imageIndex == 1 ) {
                    
                    titlelbl.text = "Upcoming Events"
                    desclbl.text = "Stay updated with all events"
                    
                    self.view.backgroundColor = UIColor(red: 136 / 255 , green: 195 / 255, blue: 227 / 255, alpha:1)
                    
                }
                else if ( imageIndex == 2 ) {
                    
                    titlelbl.text = "Contacts"
                    desclbl.text = "Salespersons, Service Technicians & Dealers"
                    self.view.backgroundColor = UIColor(red: 235 / 255 , green: 163 / 255, blue: 108 / 255, alpha:1)
                }
                else if ( imageIndex == 3 ) {
                    titlelbl.text = "Service"
                    desclbl.text = "Equipment Service Request to all Brands"
                    self.view.backgroundColor = UIColor(red: 132 / 255 , green: 207 / 255, blue: 188 / 255, alpha:1)
                }
                if ( imageIndex < 0 ) {
                    
                    imageIndex = 0
                    
                }
                else{}
                SliderImage.image = UIImage(named: bannerImages[imageIndex] as! String)
                
            case UISwipeGestureRecognizerDirection.left:
                
                
                // increase index first
                pageControl.currentPage += 1
                imageIndex += 1
                
                // check if index is in range
                
                if ( imageIndex == 0 ) {
                    
                    titlelbl.text = "Offers"
                    desclbl.text = "Get Expo Offers"
                    self.view.backgroundColor = UIColor(red: 212 / 255 , green: 108 / 255, blue: 108 / 255, alpha:1)
                    
                }
                else if ( imageIndex == 1 ) {
                    
                    titlelbl.text = "Upcoming Events"
                    desclbl.text = "Stay updated with all events"
                    
                    self.view.backgroundColor = UIColor(red: 136 / 255 , green: 195 / 255, blue: 227 / 255, alpha:1)
                    
                }
                else if ( imageIndex == 2 ) {
                    
                    titlelbl.text = "Contacts"
                    desclbl.text = "Salespersons, Service Technicians & Dealers"
                    self.view.backgroundColor = UIColor(red: 235 / 255 , green: 163 / 255, blue: 108 / 255, alpha:1)
                }
                else if ( imageIndex == 3 ) {
                    titlelbl.text = "Service"
                    desclbl.text = "Equipment Service Request to all Brands"
                    self.view.backgroundColor = UIColor(red: 132 / 255 , green: 207 / 255, blue: 188 / 255, alpha:1)
                }
                
                if ( imageIndex == maxImages ) {
                    
                    donebtn.isHidden = false
                    nextbtn.isHidden = true
                    btnImage.isHidden = true
                }
                if ( imageIndex > maxImages ) {
                    
                    imageIndex = 3
                    
                    
                }
                    
                else{}
                SliderImage.image = UIImage(named: bannerImages[imageIndex] as! String)
                
                
                
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
        
        
    }
    @IBAction func NextBtnAction(_ sender: AnyObject)
    {
        pageControl.currentPage += 1
        imageIndex += 1
        
        // check if index is in range
        
        if ( imageIndex == 0 ) {
            
            titlelbl.text = "Offers"
            desclbl.text = "Get Expo Offers"
            self.view.backgroundColor = UIColor(red: 212 / 255 , green: 108 / 255, blue: 108 / 255, alpha:1)
            
        }
        else if ( imageIndex == 1 ) {
            
            titlelbl.text = "Upcoming Events"
            desclbl.text = "Stay updated with all events"
            
            self.view.backgroundColor = UIColor(red: 136 / 255 , green: 195 / 255, blue: 227 / 255, alpha:1)
            
        }
        else if ( imageIndex == 2 ) {
            
            titlelbl.text = "Contacts"
            desclbl.text = "Salespersons, Service Technicians & Dealers"
            self.view.backgroundColor = UIColor(red: 235 / 255 , green: 163 / 255, blue: 108 / 255, alpha:1)
        }
        else if ( imageIndex == 3 ) {
            titlelbl.text = "Service"
            desclbl.text = "Equipment Service Request to all Brands"
            self.view.backgroundColor = UIColor(red: 132 / 255 , green: 207 / 255, blue: 188 / 255, alpha:1)
        }
        
        if ( imageIndex == maxImages ) {
            
            donebtn.isHidden = false
            nextbtn.isHidden = true
            btnImage.isHidden = true
        }
        if ( imageIndex > maxImages ) {
            
            imageIndex = 3
            
            
        }
            
        else{}
        SliderImage.image = UIImage(named: bannerImages[imageIndex] as! String)
        
    
}

    
    @IBAction func DoneBtnAction(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "show" , sender: self)
    }
    
}


