//
//  RealmFeatured.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 11/24/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class  RealmFeatured: NSObject, Mappable, NSCoding {

    
    var bannerDetails:Array<bannerDetail>?
    var companyDetails :Array<companyDetail>?
    
    
    func mapping(map: Map) {
        
        self.bannerDetails     <- map["banners"]
        self.companyDetails <- map["companies"]
        
        
    }
    
    
    func encode(with aCoder: NSCoder) {
       
        aCoder.encode(bannerDetails,forKey:"banners")
        aCoder.encode(companyDetails,forKey:"companies")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.bannerDetails = aDecoder.decodeObject(forKey: "banners") as! Array<bannerDetail>?
        self.companyDetails = aDecoder.decodeObject(forKey: "companies") as! Array<companyDetail>?
       
    }
    
    required init?(map: Map) {
        
        self.bannerDetails     <- map["banners"]
        self.companyDetails <- map["companies"]
        
    }

  
   
}


class bannerDetail: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }
    
     var banner_id : String?
     var banner_title: String?
     var banner_url : String?
     var banner_type : Int?
     var banner_image : String?
     var banner_type_id : Int?
    
    func mapping(map: Map) {
        
        self.banner_id <- map["banner_id"]
        self.banner_title  <- map["banner_title"]
        self.banner_url <- map["banner_url"]
        self.banner_type  <- map["banner_type"]
        self.banner_image <- map["banner_image"]
        self.banner_type_id <- map["banner_type_id"]
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(banner_id,forKey:"banner_id")
        aCoder.encode(banner_title,forKey:"banner_title")
        aCoder.encode(banner_url,forKey:"banner_url")
        aCoder.encode(banner_type,forKey:"banner_type")
        aCoder.encode(banner_image,forKey:"banner_image")
        aCoder.encode(banner_type_id,forKey:"banner_type_id")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.banner_id = aDecoder.decodeObject(forKey: "banner_id") as? String
        self.banner_title = aDecoder.decodeObject(forKey: "banner_title") as? String
        self.banner_url = aDecoder.decodeObject(forKey: "banner_url") as? String
        self.banner_type = aDecoder.decodeObject(forKey: "banner_type") as? Int
        self.banner_image = aDecoder.decodeObject(forKey: "banner_image") as? String
        self.banner_type_id = aDecoder.decodeObject(forKey: "banner_type_id") as? Int
    }
    
   
}


class companyDetail: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }
    var company_id : Int?
    var company_name : String?
    var company_website: String?
    var company_email : String?
    var company_description : String?
    var company_rating : String?
    var company_categories : String?
    var total_ratings : Int?
    var total_contacts : Int?
    var total_offers : Int?
    var total_products : Int?
    var company_image : String?
    
    
    func mapping(map: Map) {
        
        self.company_id <- map["company_id"]
        self.company_name  <- map["company_name"]
        self.company_website <- map["company_website"]
        self.company_email  <- map["company_email"]
        self.company_description <- map["company_description"]
        self.company_rating  <- map["company_rating"]
        self.company_categories <- map["company_categories"]
        self.total_ratings  <- map["total_ratings"]
        self.total_contacts <- map["total_contacts"]
        self.total_offers <- map["total_offers"]
        self.total_products <- map["total_products"]
        self.company_image <- map["company_image"]
       

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(company_id,forKey:"company_id")
        aCoder.encode(company_name,forKey:"company_name")
        aCoder.encode(company_website,forKey:"company_website")
        aCoder.encode(company_email,forKey:"company_email")
        aCoder.encode(company_description,forKey:"company_description")
        aCoder.encode(company_rating,forKey:"company_rating")
        aCoder.encode(company_categories,forKey:"company_categories")
        aCoder.encode(total_ratings,forKey:"total_ratings")
        aCoder.encode(total_contacts,forKey:"total_contacts")
        aCoder.encode(total_offers,forKey:"total_offers")
        aCoder.encode(total_products,forKey:"total_products")
        aCoder.encode(company_image,forKey:"company_image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.company_id = aDecoder.decodeObject(forKey: "company_id") as? Int
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as? String
        self.company_website = aDecoder.decodeObject(forKey: "company_website") as? String
        self.company_email = aDecoder.decodeObject(forKey: "company_email") as? String
        self.company_description = aDecoder.decodeObject(forKey: "company_description") as? String
        self.company_rating = aDecoder.decodeObject(forKey: "company_rating") as? String
        self.company_categories = aDecoder.decodeObject(forKey: "company_categories") as? String
        self.total_ratings = aDecoder.decodeObject(forKey: "total_ratings") as? Int
        self.total_contacts = aDecoder.decodeObject(forKey: "total_contacts") as? Int
        self.total_offers = aDecoder.decodeObject(forKey: "total_offers") as? Int
        self.total_products = aDecoder.decodeObject(forKey: "total_products") as? Int
        self.company_image = aDecoder.decodeObject(forKey: "company_image") as? String
        

    }
    
   
    
    
}



