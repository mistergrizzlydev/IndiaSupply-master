//
//  ProductGroup.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 10/26/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import Foundation
import ObjectMapper

class  ProductGroup: NSObject, Mappable, NSCoding {
    required init?(map: Map) {
        
    }
    
    var company_name: String?
    var company_image :String?
    var company_website: String?
    var company_email :String?
    var company_description: String?
    var company_total_contacts :Int?
     var company_categories :String?
    var company_rating: String?
    var company_total_ratings :Int?
    var company_contacts:Array<companycontacts>?
    var company_offers: String?
    var products: Array<ProductTitle>?

   
    func mapping(map: Map) {
     
        self.company_name     <- map["company_name"]
        self.company_image <- map["company_image"]
        self.company_website   <- map["company_website"]
        self.company_email     <- map["company_email"]
        self.company_description <- map["company_description"]
        self.company_total_contacts   <- map["company_total_contacts"]
        self.company_categories     <- map["company_categories"]
        self.company_rating <- map["company_rating"]
        self.company_total_ratings   <- map["company_total_ratings"]
        self.company_offers <- map["company_offers"]
        self.products   <- map["product_groups"]
        self.company_contacts   <- map["company_contacts"]
    
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(company_name,forKey:"company_name")
        aCoder.encode(company_image,forKey:"company_image")
        aCoder.encode(company_website,forKey:"company_website")
        aCoder.encode(company_email,forKey:"company_email")
        aCoder.encode(company_description,forKey:"company_description")
        aCoder.encode(company_total_contacts,forKey:"company_total_contacts")
        aCoder.encode(company_categories,forKey:"company_categories")
        aCoder.encode(company_rating,forKey:"company_rating")
        aCoder.encode(company_total_ratings,forKey:"company_total_ratings")
        aCoder.encode(company_offers,forKey:"company_offers")
        aCoder.encode(products,forKey:"products")
        aCoder.encode(company_contacts,forKey:"company_contacts")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as? String
        self.company_image = aDecoder.decodeObject(forKey: "company_image") as? String
        self.company_website = aDecoder.decodeObject(forKey: "company_website") as? String
        self.company_email = aDecoder.decodeObject(forKey: "company_email") as? String
        self.company_description = aDecoder.decodeObject(forKey: "company_description") as? String
        self.company_total_contacts = aDecoder.decodeObject(forKey: "company_total_contacts") as? Int
        self.company_categories = aDecoder.decodeObject(forKey: "company_categories") as? String
        self.company_rating = aDecoder.decodeObject(forKey: "company_rating") as? String
        self.company_total_ratings = aDecoder.decodeObject(forKey: "company_total_ratings") as? Int
        self.company_offers = aDecoder.decodeObject(forKey: "company_offers") as? String
        self.products = aDecoder.decodeObject(forKey: "products") as! Array<ProductTitle>?
        self.company_contacts = aDecoder.decodeObject(forKey: "company_contacts") as! Array<companycontacts>?
        
    }
}



class ProductTitle: NSObject, Mappable, NSCoding {
    required init?(map: Map) {
        
    }
     var group_title : String?
     var group_type : Int?
     var productsA : Array<ProductArray>?

    func mapping(map: Map) {
        
        self.group_title <- map["group_title"]
        self.group_type <- map["group_type"]
        self.productsA  <- map["products"]
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(group_title,forKey:"group_title")
        aCoder.encode(group_type,forKey:"group_type")
        aCoder.encode(productsA,forKey:"products")
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.group_title = aDecoder.decodeObject(forKey: "group_title") as? String
        self.group_type = aDecoder.decodeObject(forKey: "group_type") as? Int
        self.productsA = aDecoder.decodeObject(forKey: "products") as! Array<ProductArray>?
        
    }
}

class ProductArray: NSObject, Mappable, NSCoding {
    required init?(map: Map) {
        
    }
    var product_id : Int?
    var product_name : String?
    var product_price : String?
    var product_category : String?
    var product_image : String?
    var product_description : String?
    var product_packaging : String?
    var product_enquiry : Int?
    
    func mapping(map: Map) {
        
        self.product_id     <- map["product_id"]
        self.product_name <- map["product_name"]
        self.product_price   <- map["product_price"]
        self.product_category     <- map["product_category"]
        self.product_image <- map["product_image"]
        self.product_description   <- map["product_description"]
        self.product_packaging   <- map["product_packaging"]
        self.product_enquiry   <- map["product_enquiry"]
    
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(product_id,forKey:"product_id")
        aCoder.encode(product_name,forKey:"product_name")
        aCoder.encode(product_price,forKey:"product_price")
        aCoder.encode(product_category,forKey:"product_category")
        aCoder.encode(product_image,forKey:"product_image")
        aCoder.encode(product_description,forKey:"product_description")
        aCoder.encode(product_packaging,forKey:"product_packaging")
        aCoder.encode(product_enquiry,forKey:"product_enquiry")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.product_id = aDecoder.decodeObject(forKey: "product_id") as? Int
        self.product_name = aDecoder.decodeObject(forKey: "product_name") as? String
        self.product_price = aDecoder.decodeObject(forKey: "product_price") as? String
        self.product_category = aDecoder.decodeObject(forKey: "product_category") as? String
        self.product_image = aDecoder.decodeObject(forKey: "product_image") as? String
        self.product_description = aDecoder.decodeObject(forKey: "product_description") as? String
        self.product_packaging = aDecoder.decodeObject(forKey: "product_packaging") as? String
        self.product_enquiry = aDecoder.decodeObject(forKey: "product_enquiry") as? Int
    }
}
